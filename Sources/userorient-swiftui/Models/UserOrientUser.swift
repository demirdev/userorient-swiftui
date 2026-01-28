import Foundation

/// Represents the current user interacting with the UserOrient board.
public struct UserOrientUser: Equatable, Sendable {
    public var uniqueIdentifier: String?
    public var fullName: String?
    public var email: String?
    public var phoneNumber: String?
    public var language: String?
    public var isPaying: Bool?
    public var extra: [String: String]?

    public init(
        uniqueIdentifier: String? = nil,
        fullName: String? = nil,
        email: String? = nil,
        phoneNumber: String? = nil,
        language: String? = nil,
        isPaying: Bool? = nil,
        extra: [String: String]? = nil
    ) {
        self.uniqueIdentifier = uniqueIdentifier
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.language = language
        self.isPaying = isPaying
        self.extra = extra
    }

    /// Whether this user is anonymous (no unique identifier).
    public var isAnonymous: Bool {
        uniqueIdentifier == nil
    }

    /// A convenient anonymous user instance.
    public static let anonymous = UserOrientUser()
}

