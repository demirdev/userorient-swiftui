import Foundation

/// Represents a label attached to a feature in UserOrient.
public struct UserOrientLabel: Identifiable, Decodable, Equatable, Hashable {
    public let id: String
    public let colorHex: String
    public let names: [String: String]

    /// Whether this label marks a feature as completed.
    public var isCompleted: Bool {
        id == Self.completedLabelId
    }

    private static let completedLabelId = "07d82cf0-51ea-45d5-b274-59edb1b11a20"

    public init(id: String, colorHex: String, names: [String: String]) {
        self.id = id
        self.colorHex = colorHex
        self.names = names
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case colorHex = "color"
        case names = "name"
    }
}

