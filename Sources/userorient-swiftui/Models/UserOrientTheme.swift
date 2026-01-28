import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

/// Color configuration used by the UserOrient UI.
public struct UserOrientColors: Equatable {
    public var background: Color
    public var accent: Color

    public init(background: Color, accent: Color) {
        self.background = background
        self.accent = accent
    }
}

/// Theme configuration for light and dark appearances.
public struct UserOrientTheme: Equatable {
    public var light: UserOrientColors?
    public var dark: UserOrientColors?

    public init(light: UserOrientColors? = nil, dark: UserOrientColors? = nil) {
        self.light = light
        self.dark = dark
    }

    /// Default theme that adapts to the current platform.
    public static var `default`: UserOrientTheme {
        #if os(iOS)
        let lightBackground = Color(.systemBackground)
        let darkBackground = Color(.black)
        #elseif os(macOS)
        let lightBackground = Color(nsColor: .windowBackgroundColor)
        let darkBackground = Color(nsColor: .textBackgroundColor)
        #else
        let lightBackground = Color.white
        let darkBackground = Color.black
        #endif

        let accent = Color.accentColor

        return UserOrientTheme(
            light: UserOrientColors(background: lightBackground, accent: accent),
            dark: UserOrientColors(background: darkBackground, accent: accent)
        )
    }
}

