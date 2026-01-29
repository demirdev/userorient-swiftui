import Foundation

/// Low-level HTTP client that talks to the UserOrient backend.
struct UserOrientAPI {
    private static let baseURLString = "https://api.userorient.com"

    // MARK: - Public HTTP operations

    static func fetchFeatures(
        projectId: String,
        userId: String
    ) async throws -> [UserOrientFeature] {
        let urlString = "\(baseURLString)/sdk/feature/all?projectId=\(projectId)&userId=\(userId)"
        let url = try makeURL(from: urlString)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        #if DEBUG
        if let raw = String(data: data, encoding: .utf8) {
            print("[UserOrient] fetchFeatures raw response: \(raw)")
        } else {
            print("[UserOrient] fetchFeatures raw data (invalid UTF-8), length: \(data.count)")
        }
        if let http = response as? HTTPURLResponse {
            print("[UserOrient] fetchFeatures HTTP status: \(http.statusCode)")
        }
        #endif

        try validate(response: response, data: data)

        do {
            let decoded = try JSONDecoder().decode(FeaturesResponse.self, from: data)
            return decoded.features.sorted { $0.voteCount > $1.voteCount }
        } catch {
            throw UserOrientError.decodingError(underlying: error)
        }
    }

    static func syncUser(
        projectId: String,
        cachedUserId: String?,
        user: UserOrientUser
    ) async throws -> String {
        let urlString = "\(baseURLString)/sdk/user/sync?projectId=\(projectId)"
        let url = try makeURL(from: urlString)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = SyncUserPayload(user: user, userId: cachedUserId)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(payload)

        let (data, response) = try await URLSession.shared.data(for: request)

        #if DEBUG
        if let raw = String(data: data, encoding: .utf8) {
            print("[UserOrient] syncUser raw response: \(raw)")
        } else {
            print("[UserOrient] syncUser raw data (invalid UTF-8), length: \(data.count)")
        }
        if let http = response as? HTTPURLResponse {
            print("[UserOrient] syncUser HTTP status: \(http.statusCode)")
        }
        #endif

        try validate(response: response, data: data)

        do {
            let decoded = try JSONDecoder().decode(SyncUserResponse.self, from: data)
            return decoded.id
        } catch {
            throw UserOrientError.decodingError(underlying: error)
        }
    }

    static func toggleUpvote(
        projectId: String,
        userId: String,
        featureId: String
    ) async throws {
        let urlString = "\(baseURLString)/sdk/feature/toggle?projectId=\(projectId)"
        let url = try makeURL(from: urlString)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "userId": userId,
            "featureId": featureId,
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response, data: data)
        _ = data // currently unused; kept for potential logging
    }

    static func sendFeatureRequest(
        projectId: String,
        userId: String,
        content: String
    ) async throws {
        let urlString = "\(baseURLString)/sdk/feedback?projectId=\(projectId)"
        let url = try makeURL(from: urlString)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "userId": userId,
            "description": [
                "en": content,
            ],
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response, data: data)
        _ = data
    }

    static func fetchComments(
        projectId: String,
        userId: String,
        featureId: String
    ) async throws -> [UserOrientComment] {
        let urlString = "\(baseURLString)/sdk/comment/all?projectId=\(projectId)&userId=\(userId)&featureId=\(featureId)"
        let url = try makeURL(from: urlString)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response, data: data)

        do {
            let decoded = try JSONDecoder().decode(CommentsResponse.self, from: data)
            return decoded.comments
        } catch {
            throw UserOrientError.decodingError(underlying: error)
        }
    }

    static func addComment(
        projectId: String,
        userId: String,
        featureId: String,
        content: String
    ) async throws {
        let urlString = "\(baseURLString)/sdk/comment?projectId=\(projectId)"
        let url = try makeURL(from: urlString)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "userId": userId,
            "featureId": featureId,
            "content": content,
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response, data: data)
        _ = data
    }

    // MARK: - Private helpers

    private static func makeURL(from string: String) throws -> URL {
        guard let url = URL(string: string) else {
            throw UserOrientError.invalidResponse
        }
        return url
    }

    private static func validate(response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else {
            throw UserOrientError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw UserOrientError.httpError(statusCode: http.statusCode)
        }
        _ = data
    }
}

// MARK: - DTOs

private struct FeaturesResponse: Decodable {
    let features: [UserOrientFeature]
}

private struct CommentsResponse: Decodable {
    let comments: [UserOrientComment]
}

private struct SyncUserResponse: Decodable {
    let id: String
}

private struct SyncUserPayload: Encodable {
    let user: UserOrientUser
    let userId: String?

    private enum CodingKeys: String, CodingKey {
        case userId
        case uniqueIdentifier
        case fullName
        case email
        case phoneNumber
        case language
        case extra
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(userId, forKey: .userId)
        try container.encodeIfPresent(user.uniqueIdentifier, forKey: .uniqueIdentifier)
        try container.encodeIfPresent(user.fullName, forKey: .fullName)
        try container.encodeIfPresent(user.email, forKey: .email)
        try container.encodeIfPresent(user.phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(user.language, forKey: .language)

        if user.extra != nil || user.isPaying != nil {
            var extraContainer = container.nestedContainer(keyedBy: ExtraCodingKeys.self, forKey: .extra)

            if let isPaying = user.isPaying {
                if let key = ExtraCodingKeys(stringValue: "isPaying") {
                    try extraContainer.encode(isPaying, forKey: key)
                }
            }

            if let extra = user.extra {
                for (key, value) in extra {
                    guard let codingKey = ExtraCodingKeys(stringValue: key) else { continue }
                    try extraContainer.encode(value, forKey: codingKey)
                }
            }
        }
    }
}

private struct ExtraCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}


