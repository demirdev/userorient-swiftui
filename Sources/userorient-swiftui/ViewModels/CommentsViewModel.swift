import Foundation

@MainActor
final class CommentsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var comments: [UserOrientComment] = []
    @Published var newCommentText: String = ""
    @Published var isAddingComment = false

    let feature: UserOrientFeature

    init(feature: UserOrientFeature) {
        self.feature = feature
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            try await UserOrientClient.shared.loadComments(for: feature)
            comments = UserOrientClient.shared.comments
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func addComment() async {
        let content = newCommentText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !content.isEmpty else { return }

        isAddingComment = true
        errorMessage = nil

        do {
            let author = UserOrientClient.shared.currentUserFullName
            try await UserOrientClient.shared.addComment(
                content: content,
                featureId: feature.id,
                authorFullName: author
            )
            comments = UserOrientClient.shared.comments
            newCommentText = ""
        } catch {
            errorMessage = error.localizedDescription
        }

        isAddingComment = false
    }
}

