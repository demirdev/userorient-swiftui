import Foundation

/// Internal configuration object for the UserOrient SDK.
struct UserOrientConfiguration {
    var apiKey: String
    var languageCode: String
    var theme: UserOrientTheme
    var user: UserOrientUser?

    static let defaultLanguageCode = "en"
}

/// Errors that can be thrown by the UserOrient SDK.
public enum UserOrientError: Error, LocalizedError {
    case notConfigured
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(underlying: Error)
    case storageError

    public var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "UserOrient SDK is not configured. Call configure(apiKey:languageCode:) first."
        case .invalidResponse:
            return "Received an invalid response from the UserOrient service."
        case .httpError(let statusCode):
            return "UserOrient request failed with status code \(statusCode)."
        case .decodingError(let underlying):
            return "Failed to decode UserOrient response: \(underlying.localizedDescription)"
        case .storageError:
            return "Failed to access UserOrient persistent storage."
        }
    }
}

