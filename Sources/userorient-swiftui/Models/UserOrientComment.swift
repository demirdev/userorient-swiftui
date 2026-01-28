import Foundation

/// Represents a comment attached to a feature.
public struct UserOrientComment: Identifiable, Decodable, Equatable {
    public let id: String
    public let content: String
    public let ownerFullName: String?
    public let createdAt: Date?

    private enum CodingKeys: String, CodingKey {
        case id
        case content
        case ownerFullName
        case createdAt
    }

    public init(
        id: String,
        content: String,
        ownerFullName: String?,
        createdAt: Date?
    ) {
        self.id = id
        self.content = content
        self.ownerFullName = ownerFullName
        self.createdAt = createdAt
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        content = try container.decode(String.self, forKey: .content)
        ownerFullName = try container.decodeIfPresent(String.self, forKey: .ownerFullName)

        if let createdAtString = try container.decodeIfPresent(String.self, forKey: .createdAt),
           !createdAtString.isEmpty {
            createdAt = ISO8601DateFormatter().date(from: createdAtString)
        } else {
            createdAt = nil
        }
    }
}

