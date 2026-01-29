import Foundation

/// Represents a feature item shown on the UserOrient board.
public struct UserOrientFeature: Identifiable, Decodable, Equatable {
    public let id: String
    public let status: String
    public let projectId: String
    public let ownerType: String
    public let ownerFirstName: String?
    public let ownerLastName: String?
    public let voteCount: Int
    public let createdAt: Date?
    public let voted: Bool
    public let title: [String: String]
    public let description: [String: String]
    public let labels: [UserOrientLabel]
    public let commentsCount: Int?

    /// Returns the localized title for a given language code, falling back to English.
    public func title(for languageCode: String?) -> String {
        guard let languageCode, !languageCode.isEmpty else {
            return title["en"] ?? "N/A"
        }
        return title[languageCode] ?? title["en"] ?? "N/A"
    }

    /// Returns the localized description for a given language code, falling back to English.
    public func description(for languageCode: String?) -> String {
        guard let languageCode, !languageCode.isEmpty else {
            return description["en"] ?? "N/A"
        }
        return description[languageCode] ?? description["en"] ?? "N/A"
    }

    /// Whether this feature is considered completed (based on attached labels).
    public var isCompleted: Bool {
        labels.contains(where: { $0.isCompleted })
    }

    /// Placeholder feature for loading states. Use `skeleton(placeholderIndex:)` for lists so each item has a unique id.
    public static func skeleton(placeholderIndex: Int) -> UserOrientFeature {
        UserOrientFeature(
            id: "skeleton-\(placeholderIndex)",
            status: "skeleton",
            projectId: "skeleton",
            ownerType: "skeleton",
            ownerFirstName: "skeleton",
            ownerLastName: "skeleton",
            voteCount: 0,
            createdAt: Date(),
            voted: false,
            title: [:],
            description: [:],
            labels: [],
            commentsCount: 0
        )
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case status
        case projectId
        case ownerType
        case ownerFirstName
        case ownerLastName
        case voteCount
        case createdAt
        case voted
        case title
        case description
        case labels
        case commentsCount
    }

    public init(
        id: String,
        status: String,
        projectId: String,
        ownerType: String,
        ownerFirstName: String?,
        ownerLastName: String?,
        voteCount: Int,
        createdAt: Date?,
        voted: Bool,
        title: [String: String],
        description: [String: String],
        labels: [UserOrientLabel],
        commentsCount: Int?
    ) {
        self.id = id
        self.status = status
        self.projectId = projectId
        self.ownerType = ownerType
        self.ownerFirstName = ownerFirstName
        self.ownerLastName = ownerLastName
        self.voteCount = voteCount
        self.createdAt = createdAt
        self.voted = voted
        self.title = title
        self.description = description
        self.labels = labels
        self.commentsCount = commentsCount
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        status = try container.decode(String.self, forKey: .status)
        projectId = try container.decode(String.self, forKey: .projectId)
        ownerType = try container.decode(String.self, forKey: .ownerType)
        ownerFirstName = try container.decodeIfPresent(String.self, forKey: .ownerFirstName)
        ownerLastName = try container.decodeIfPresent(String.self, forKey: .ownerLastName)
        voteCount = try container.decode(Int.self, forKey: .voteCount)

        if let createdAtString = try container.decodeIfPresent(String.self, forKey: .createdAt),
           !createdAtString.isEmpty {
            createdAt = ISO8601DateFormatter().date(from: createdAtString)
        } else {
            createdAt = nil
        }

        voted = try container.decode(Bool.self, forKey: .voted)
        title = try container.decodeIfPresent([String: String].self, forKey: .title) ?? [:]
        description = try container.decodeIfPresent([String: String].self, forKey: .description) ?? [:]
        labels = try container.decodeIfPresent([UserOrientLabel].self, forKey: .labels) ?? []
        commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount)
    }
}

