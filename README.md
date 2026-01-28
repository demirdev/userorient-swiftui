UserOrient SwiftUI
==================

All planned TODOs are complete. `userorient-swiftui` builds for **iOS 15+** and **macOS 12+**, and all tests are currently passing.

## How to use in a SwiftUI app

```swift
import SwiftUI
import userorient_swiftui

@main
struct MyApp: App {
    init() {
        UserOrient.configure(apiKey: "<YOUR_API_KEY>", languageCode: "en")
        UserOrient.setUser(
            UserOrientUser(
                uniqueIdentifier: "user-123",
                fullName: "Jane Doe",
                email: "jane@example.com",
                language: "en",
                isPaying: true
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            // Works on both iOS and macOS
            UserOrientBoardView()
        }
    }
}
```

If you want, as a next step we can do a small refinement pass on the API surface or UI details (colors, icons, navigation behavior) to make them feel even more “Swifty”.

