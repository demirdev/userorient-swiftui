import Foundation
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

/// Mirrors the API response shape used in UserOrientAPI to trigger the same decoding path.
private struct FeaturesResponseDecodable: Decodable {
    let features: [UserOrientFeature]
}

@Test
func decodingUserOrientResponseWithMissingDataThrowsDecodingError() async throws {
    // Empty JSON triggers "keyNotFound" for "features" -> DecodingError with "data is missing"
    let emptyJSON = "{}".data(using: .utf8)!
    var decodingError: Error?
    do {
        _ = try JSONDecoder().decode(FeaturesResponseDecodable.self, from: emptyJSON)
    } catch {
        decodingError = error
    }
    #expect(decodingError != nil)

    let wrapped = UserOrientError.decodingError(underlying: decodingError!)
    let description = wrapped.errorDescription ?? ""
    #expect(description.contains("Failed to decode UserOrient response"))
    #expect(description.contains("missing"))
}

@Test
func decodingFeaturesResponseWithNullTitleAndDescriptionValuesSucceeds() async throws {
    // API returns title/description as objects with null locale values; decoding must strip nulls.
    let json = """
    {
      "features": [
        {
          "id": "2ea45c8c-acb6-4a08-a7d9-b4bdcf65855d",
          "status": "APPROVED",
          "projectId": "5cbc468e-358b-445e-bf23-291f1cad55f0",
          "ownerId": "8ccde89b-e887-40f9-95d0-7380a596a034",
          "ownerType": "sdk_user",
          "ownerEmail": null,
          "ownerFirstName": null,
          "ownerLastName": "",
          "voteCount": 1,
          "createdAt": "2026-01-29T05:05:47.570Z",
          "voted": true,
          "commentsCount": 0,
          "title": { "en": "test fdasf ads", "az": null, "ru": null },
          "description": { "en": "test fdasf ads", "az": null, "ru": null },
          "labels": []
        }
      ],
      "meta": { "perPage": 75, "currentPage": 1, "pageCount": 1, "totalCount": 1 }
    }
    """
    let data = json.data(using: .utf8)!
    let decoded = try JSONDecoder().decode(FeaturesResponseDecodable.self, from: data)

    #expect(decoded.features.count == 1)
    let feature = decoded.features[0]
    #expect(feature.id == "2ea45c8c-acb6-4a08-a7d9-b4bdcf65855d")
    #expect(feature.status == "APPROVED")
    #expect(feature.voted == true)
    #expect(feature.voteCount == 1)
    #expect(feature.labels.isEmpty)

    // Null locale keys must be stripped; only non-null values remain.
    #expect(feature.title == ["en": "test fdasf ads"])
    #expect(feature.description == ["en": "test fdasf ads"])
    #expect(feature.title(for: "en") == "test fdasf ads")
    #expect(feature.title(for: "az") == "test fdasf ads")
}

