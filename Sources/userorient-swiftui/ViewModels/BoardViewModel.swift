import Foundation

@MainActor
final class BoardViewModel: ObservableObject {
    enum Tab {
        case roadmap
        case implemented
    }

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var features: [UserOrientFeature] = []
    @Published var selectedTab: Tab = .roadmap

    var displayedFeatures: [UserOrientFeature] {
        let source: [UserOrientFeature]

        if isLoading && features.isEmpty {
            source = Array(repeating: .skeleton, count: 9)
        } else {
            source = features
        }

        return source.filter { feature in
            switch selectedTab {
            case .roadmap:
                return !feature.isCompleted
            case .implemented:
                return feature.isCompleted
            }
        }
    }

    var languageCode: String {
        (UserOrientClient.shared.configurationLanguageCode ?? UserOrientConfiguration.defaultLanguageCode)
    }

    // MARK: - API

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            try await UserOrientClient.shared.ensureInitialized()
            features = UserOrientClient.shared.features
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func refresh() async {
        await load()
    }

    func toggleUpvote(for feature: UserOrientFeature) async {
        do {
            try await UserOrientClient.shared.toggleUpvote(for: feature)
            features = UserOrientClient.shared.features
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

