import SwiftUI

/// Public entry point for the UserOrient SwiftUI SDK.
@MainActor
public enum UserOrient {
    /// Configure the SDK with your project API key and preferred language code.
    public static func configure(apiKey: String, languageCode: String = "en") {
        UserOrientClient.shared.configure(apiKey: apiKey, languageCode: languageCode)
    }

    /// Set information about the current user.
    public static func setUser(_ user: UserOrientUser) {
        UserOrientClient.shared.setUser(user)
    }

    /// Apply a custom theme for the UserOrient UI.
    public static func setTheme(_ theme: UserOrientTheme) {
        UserOrientClient.shared.setTheme(theme)
    }

    /// Clear all cached data (user UUID, project cache, in-memory state).
    public static func clearCache() async {
        await UserOrientClient.shared.clearCache()
    }
}

