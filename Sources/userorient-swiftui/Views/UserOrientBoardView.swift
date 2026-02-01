import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

/// Main entry SwiftUI view that presents the UserOrient feature board.
public struct UserOrientBoardView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = BoardViewModel()
    @State private var showingForm = false
    @State private var selectedFeatureForComments: UserOrientFeature?

    public init() {}

    public var body: some View {
        Group {
            #if os(macOS)
            // On macOS, avoid NavigationView to prevent empty detail column on the right.
            // Use a plain stack and overlay the close button at top-right.
            mainContent
                .overlay(alignment: .topTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.secondary)
                            .frame(width: 24, height: 24)
                            .background(Color.primary.opacity(0.08))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .padding(12)
                }
            #else
            NavigationView {
                mainContent
                #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
            #endif
        }
        .task { @MainActor in
            await viewModel.load()
        }
        .sheet(item: $selectedFeatureForComments) { feature in
            CommentsScreen(feature: feature)
        }
        .sheet(isPresented: $showingForm) {
            featureFormSheetContent
        }
    }

    @ViewBuilder
    private var featureFormSheetContent: some View {
        let form = FeatureFormScreen()
        #if os(iOS)
        if #available(iOS 16.0, *) {
            form
                .presentationDetents([.height(FeatureFormScreen.defaultSheetHeight), .large])
                .presentationDragIndicator(.visible)
        } else {
            form
        }
        #else
        form
            .frame(
                minWidth: FeatureFormScreen.defaultSheetWidth,
                idealWidth: FeatureFormScreen.defaultSheetWidth,
                minHeight: FeatureFormScreen.defaultSheetHeight,
                idealHeight: FeatureFormScreen.defaultSheetHeight
            )
        #endif
    }

    private var mainContent: some View {
        VStack(spacing: 0) {
            tabs

            if viewModel.selectedTab == .roadmap {
                TipView()
            }

            content

            WatermarkView {
                showingForm = true
            }
        }
    }

    private var tabs: some View {
        HStack {
            Spacer()
            HStack(spacing: 2) {
                tabButton(
                    title: UserOrientStrings.roadmap(languageCode: viewModel.languageCode),
                    isActive: viewModel.selectedTab == .roadmap
                ) {
                    viewModel.selectedTab = .roadmap
                }
                tabButton(
                    title: UserOrientStrings.implemented(languageCode: viewModel.languageCode),
                    isActive: viewModel.selectedTab == .implemented
                ) {
                    viewModel.selectedTab = .implemented
                }
            }
            .padding(4)
            .background(
                Capsule()
                    .fill(Color.secondary.opacity(0.12))
            )
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    private func tabButton(
        title: String,
        isActive: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 24)
                .padding(.vertical, 6)
                .frame(height: 32)
                .foregroundColor(isActive ? Color.white : Color.primary)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isActive ? Color.accentColor : Color.clear)
                )
        }
        .buttonStyle(.plain)
    }

    private var content: some View {
        Group {
            if let error = viewModel.errorMessage {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Retry") {
                        Task { await viewModel.refresh() }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.displayedFeatures.isEmpty && !viewModel.isLoading {
                VStack {
                    Text(UserOrientStrings.emptyTitle(languageCode: viewModel.languageCode))
                        .font(.headline)
                        .padding(.bottom, 4)
                    Text(UserOrientStrings.emptySubtitle(languageCode: viewModel.languageCode))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.displayedFeatures) { feature in
                            FeatureCardView(
                                feature: feature,
                                languageCode: viewModel.languageCode,
                                isSkeleton: viewModel.isLoading && feature.id.hasPrefix("skeleton"),
                                onToggleUpvote: {
                                    Task {
                                        await viewModel.toggleUpvote(for: feature)
                                    }
                                },
                                onOpenComments: {
                                    selectedFeatureForComments = feature
                                }
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Supporting views

struct FeatureCardView: View {
    let feature: UserOrientFeature
    let languageCode: String
    let isSkeleton: Bool
    let onToggleUpvote: () -> Void
    let onOpenComments: () -> Void

    var body: some View {
        Button(action: onOpenComments) {
            HStack(alignment: .top, spacing: 12) {
                upvoteButton

                VStack(alignment: .leading, spacing: 4) {
                    Text(feature.title(for: languageCode))
                        .font(.headline)
                        .foregroundColor(.primary)
                        .redacted(reason: isSkeleton ? .placeholder : [])

                    Text(feature.description(for: languageCode))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .redacted(reason: isSkeleton ? .placeholder : [])

                    labelsRow

                    HStack(spacing: 4) {
                        Image(systemName: "text.bubble")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text("\(feature.commentsCount ?? 0)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 6)
                    .redacted(reason: isSkeleton ? .placeholder : [])
                }

                Spacer(minLength: 8)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .disabled(isSkeleton)
    }

    private var isCompleted: Bool {
        feature.isCompleted
    }

    private var upvoteButton: some View {
        Button(action: {
            guard !isCompleted, !isSkeleton else { return }
            onToggleUpvote()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(upvoteBackgroundColor)
                    .frame(width: 56, height: 56)

                if isCompleted {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                } else {
                    VStack(spacing: 4) {
                        Image(systemName: feature.voted ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.system(size: 20))
                            .foregroundColor(feature.voted ? .white : .gray)
                        Text("\(feature.voteCount)")
                            .font(.subheadline)
                            .foregroundColor(feature.voted ? .white : .primary)
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(isSkeleton)
    }

    private var upvoteBackgroundColor: Color {
        if isCompleted {
            return Color.green.opacity(0.2)
        }
        if feature.voted {
            return Color.accentColor
        }
        return Color.secondary.opacity(0.1)
    }

    private var labelsRow: some View {
        let nonCompleted = feature.labels.filter { !$0.isCompleted }
        guard !nonCompleted.isEmpty else {
            return AnyView(EmptyView())
        }

        return AnyView(
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(nonCompleted) { label in
                        Text(label.names[languageCode] ?? label.names["en"] ?? "")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(color(from: label.colorHex).opacity(0.1))
                            )
                            .foregroundColor(color(from: label.colorHex))
                    }
                }
            }
            .padding(.top, 4)
        )
    }

    private func color(from hex: String) -> Color {
        let cleaned = hex.replacingOccurrences(of: "#", with: "")
        guard let value = UInt(cleaned, radix: 16) else {
            return .accentColor
        }
        let red = Double((value >> 16) & 0xFF) / 255
        let green = Double((value >> 8) & 0xFF) / 255
        let blue = Double(value & 0xFF) / 255
        return Color(red: red, green: green, blue: blue)
    }
}

struct TipView: View {
    @State private var showTip = false

    private let storageKey = "userorient_swiftui_tip_shown"

    var body: some View {
        Group {
            if showTip {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(Color.blue)

                    Text(UserOrientStrings.tip(languageCode: nil))
                        .font(.subheadline)
                        .foregroundColor(Color.blue)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue.opacity(0.1))
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .onAppear {
            let defaults = UserDefaults.standard
            let hasShown = defaults.bool(forKey: storageKey)
            if !hasShown {
                showTip = true
                defaults.set(true, forKey: storageKey)
            }
        }
    }
}

struct WatermarkView: View {
    var onAddFeature: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Divider()
            Button(action: onAddFeature) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text(UserOrientStrings.addFeature(languageCode: nil))
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.accentColor)
                )
            }
            .buttonStyle(.plain)

            Button(action: openUserOrient) {
                HStack(spacing: 4) {
                    Image(systemName: "link")
                        .font(.system(size: 12))
                    Text("Powered by UserOrient")
                        .font(.caption)
                }
                .foregroundColor(Color.gray)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 8)
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }

    private func openUserOrient() {
        guard let url = URL(string: "https://userorient.com") else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #elseif canImport(AppKit)
        NSWorkspace.shared.open(url)
        #endif
    }
}


