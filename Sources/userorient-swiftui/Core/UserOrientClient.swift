import Foundation

@MainActor
final class UserOrientClient: ObservableObject {
    static let shared = UserOrientClient()

    @Published private(set) var features: [UserOrientFeature] = []
    @Published private(set) var comments: [UserOrientComment] = []

    private var configuration: UserOrientConfiguration?
    private var pendingUser: UserOrientUser?
    private var userUUID: String?
    private var isInitialized = false

    private init() {}

    var configurationLanguageCode: String? {
        configuration?.languageCode
    }

    var currentUserFullName: String? {
        configuration?.user?.fullName
    }

    // MARK: - Configuration

    func configure(apiKey: String, languageCode: String) {
        let normalizedLanguage = languageCode.lowercased()
        let user = configuration?.user ?? pendingUser
        configuration = UserOrientConfiguration(
            apiKey: apiKey,
            languageCode: normalizedLanguage,
            theme: .default,
            user: user
        )
        pendingUser = nil
    }

    func setUser(_ user: UserOrientUser) {
        if var config = configuration {
            config.user = user
            configuration = config
        } else {
            pendingUser = user
        }
    }

    func setTheme(_ theme: UserOrientTheme) {
        guard var config = configuration else { return }
        config.theme = theme
        configuration = config
    }

    func clearCache() async {
        isInitialized = false
        userUUID = nil
        features = []
        comments = []
        UserOrientStorage.clear()
    }

    // MARK: - Initialization

    func ensureInitialized() async throws {
        guard var config = configuration, !config.apiKey.isEmpty else {
            throw UserOrientError.notConfigured
        }

        let cachedProjectId = UserOrientStorage.currentProjectId()
        let hasProjectId = cachedProjectId != nil
        let projectChanged = hasProjectId && cachedProjectId != config.apiKey

        if projectChanged {
            await clearCache()
        }

        if !isInitialized {
            let user = config.user ?? .anonymous

            let uuid: String
            if let cached = UserOrientStorage.userUUID() {
                uuid = cached
            } else {
                uuid = try await UserOrientAPI.syncUser(
                    projectId: config.apiKey,
                    cachedUserId: nil,
                    user: user
                )
                UserOrientStorage.cacheUserUUID(uuid)
            }

            userUUID = uuid
            try await refreshFeatures()

            UserOrientStorage.cacheProjectId(config.apiKey)
            isInitialized = true
        } else {
            try await refreshFeatures()
        }
    }

    // MARK: - Data operations

    func refreshFeatures() async throws {
        guard let config = configuration, let userUUID else {
            throw UserOrientError.notConfigured
        }

        let fetched = try await UserOrientAPI.fetchFeatures(
            projectId: config.apiKey,
            userId: userUUID
        )
        features = fetched
    }

    func toggleUpvote(for feature: UserOrientFeature) async throws {
        guard let config = configuration, let userUUID else {
            throw UserOrientError.notConfigured
        }

        // Optimistic local update.
        features = features.map { current in
            guard current.id == feature.id else { return current }
            let newVoted = !current.voted
            let newVoteCount = newVoted ? current.voteCount + 1 : max(0, current.voteCount - 1)
            return UserOrientFeature(
                id: current.id,
                status: current.status,
                projectId: current.projectId,
                ownerType: current.ownerType,
                ownerFirstName: current.ownerFirstName,
                ownerLastName: current.ownerLastName,
                voteCount: newVoteCount,
                createdAt: current.createdAt,
                voted: newVoted,
                title: current.title,
                description: current.description,
                labels: current.labels,
                commentsCount: current.commentsCount
            )
        }

        try await UserOrientAPI.toggleUpvote(
            projectId: config.apiKey,
            userId: userUUID,
            featureId: feature.id
        )
    }

    func submitFeatureRequest(content: String) async throws {
        guard let config = configuration, let userUUID else {
            throw UserOrientError.notConfigured
        }

        try await UserOrientAPI.sendFeatureRequest(
            projectId: config.apiKey,
            userId: userUUID,
            content: content
        )
    }

    func loadComments(for feature: UserOrientFeature) async throws {
        guard let config = configuration, let userUUID else {
            throw UserOrientError.notConfigured
        }

        comments = []

        let loaded = try await UserOrientAPI.fetchComments(
            projectId: config.apiKey,
            userId: userUUID,
            featureId: feature.id
        )

        comments = loaded
    }

    func addComment(content: String, featureId: String, authorFullName: String?) async throws {
        guard let config = configuration, let userUUID else {
            throw UserOrientError.notConfigured
        }

        try await UserOrientAPI.addComment(
            projectId: config.apiKey,
            userId: userUUID,
            featureId: featureId,
            content: content
        )

        let newComment = UserOrientComment(
            id: String(Int(Date().timeIntervalSince1970 * 1000)),
            content: content,
            ownerFullName: authorFullName,
            createdAt: Date()
        )

        comments.insert(newComment, at: 0)
    }
}

