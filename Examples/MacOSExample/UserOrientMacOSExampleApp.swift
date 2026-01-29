import SwiftUI
import userorient_swiftui

@main
struct UserOrientMacOSExampleApp: App {
    init() {
        UserOrient.configure(apiKey: "<YOUR_API_KEY>", languageCode: "en")
        UserOrient.setUser(
            UserOrientUser(
                uniqueIdentifier: "macos-example-user",
                fullName: "Mac Example User",
                email: "mac@example.com",
                language: "en",
                isPaying: true
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            UserOrientBoardView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(.automatic)
    }
}
