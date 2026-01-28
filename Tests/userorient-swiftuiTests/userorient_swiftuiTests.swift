import Testing
@testable import userorient_swiftui

@Test
func localizationMatchesFlutterContent() async throws {
    #expect(UserOrientStrings.title(languageCode: "en") == "Features")
    #expect(UserOrientStrings.title(languageCode: "tr") == "Öneriler")
    #expect(UserOrientStrings.roadmap(languageCode: "en") == "Roadmap")
    #expect(UserOrientStrings.implemented(languageCode: "en") == "Implemented")
}

@Test
func defaultThemeProvidesLightAndDarkColors() async throws {
    let theme = UserOrientTheme.default
    #expect(theme.light != nil)
    #expect(theme.dark != nil)
}

@Test
func featureCompletionDetectionUsesCompletedLabelId() async throws {
    let completedLabel = UserOrientLabel(
        id: "07d82cf0-51ea-45d5-b274-59edb1b11a20",
        colorHex: "#00FF00",
        names: ["en": "Done"]
    )

    let feature = UserOrientFeature(
        id: "1",
        status: "done",
        projectId: "p",
        ownerType: "owner",
        ownerFirstName: nil,
        ownerLastName: nil,
        voteCount: 0,
        createdAt: nil,
        voted: false,
        title: ["en": "Test"],
        description: ["en": "Description"],
        labels: [completedLabel],
        commentsCount: 0
    )

    #expect(feature.isCompleted == true)
}

