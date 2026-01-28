import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

struct CommentsScreen: View {
    @StateObject private var viewModel: CommentsViewModel

    init(feature: UserOrientFeature) {
        _viewModel = StateObject(wrappedValue: CommentsViewModel(feature: feature))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                content
                commentInput
            }
            .navigationTitle(UserOrientStrings.comments(languageCode: nil))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        .task {
            await viewModel.load()
        }
    }

    private var content: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task { await viewModel.load() }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.comments.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .font(.system(size: 32))
                        .foregroundColor(.secondary)
                    Text(UserOrientStrings.noCommentsTitle(languageCode: nil))
                        .font(.headline)
                    Text(UserOrientStrings.noCommentsSubtitle(languageCode: nil))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.comments) { comment in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(comment.ownerFullName ?? UserOrientStrings.guestUser(languageCode: nil))
                                .font(.headline)
                            if let date = comment.createdAt {
                                Text(UserOrientDateFormatter.relativeString(for: date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Text(comment.content)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
    }

    private var commentInput: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                TextField(UserOrientStrings.addCommentPlaceholder(languageCode: nil), text: $viewModel.newCommentText)
                    .textFieldStyle(.roundedBorder)

                Button(action: {
                    Task { await viewModel.addComment() }
                }) {
                    if viewModel.isAddingComment {
                        ProgressView()
                            .progressViewStyle(.circular)
                    } else {
                        Image(systemName: "paperplane.fill")
                    }
                }
                .disabled(viewModel.newCommentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isAddingComment)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(
            platformSecondaryBackgroundColor()
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

private func platformSecondaryBackgroundColor() -> Color {
    #if canImport(UIKit)
    return Color(UIColor.secondarySystemBackground)
    #elseif canImport(AppKit)
    return Color(nsColor: .windowBackgroundColor)
    #else
    return Color.secondary.opacity(0.1)
    #endif
}


