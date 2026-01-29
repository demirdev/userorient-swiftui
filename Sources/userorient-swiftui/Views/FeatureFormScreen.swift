import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

struct FeatureFormScreen: View {
    /// Default size for the suggest-feature sheet so the form is visible.
    static let defaultSheetWidth: CGFloat = 520
    static let defaultSheetHeight: CGFloat = 560

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FormViewModel()

    private var toolbarClosePlacement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarTrailing
        #else
        .primaryAction
        #endif
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                #if os(macOS)
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.secondary)
                            .frame(width: 24, height: 24)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                #endif
                if !viewModel.isSent {
                    formBody
                        .frame(minHeight: 200, maxHeight: .infinity)
                }
                footer
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(minHeight: Self.defaultSheetHeight)
            .navigationTitle(UserOrientStrings.addFeature(languageCode: nil))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            #if os(macOS)
            .frame(minWidth: Self.defaultSheetWidth, idealWidth: Self.defaultSheetWidth, minHeight: Self.defaultSheetHeight, idealHeight: Self.defaultSheetHeight)
            #endif
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: toolbarClosePlacement) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                #endif
            }
        }
        .alert(
            UserOrientStrings.errorTitle(languageCode: nil),
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { newValue in
                    if !newValue {
                        viewModel.errorMessage = nil
                    }
                }
            ),
            actions: {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            },
            message: {
                Text(viewModel.errorMessage ?? "")
            }
        )
    }

    private var formBody: some View {
        VStack(spacing: 8) {
            TextEditor(text: $viewModel.text)
                .modifier(HideScrollContentBackgroundModifier())
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 160, maxHeight: .infinity)
                .background(Color.primary.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onChange(of: viewModel.text) { newValue in
                    if newValue.count > 500 {
                        viewModel.text = String(newValue.prefix(500))
                    }
                }

            HStack {
                Spacer()
                Text("\(viewModel.characterCount)/500")
                    .font(.caption)
                    .foregroundColor(counterColor)
                    .padding(.trailing, 20)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var counterColor: Color {
        if viewModel.characterCount == 0 {
            return .secondary.opacity(0.5)
        }
        if viewModel.characterCount < 10 {
            return .red
        }
        return .secondary
    }

    private var footer: some View {
        VStack(spacing: 16) {
            if viewModel.isSent {
                SentView {
                    dismiss()
                }
            } else {
                Button(action: {
                    Task { await viewModel.submit() }
                }) {
                    if viewModel.isSubmitting {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                    } else {
                        Text(UserOrientStrings.submitForm(languageCode: nil))
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(viewModel.isValid ? Color.accentColor : Color.gray.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .disabled(!viewModel.isValid || viewModel.isSubmitting)
            }
        }
        .padding(.vertical, 16)
        .background(
            platformFormBackgroundColor()
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

struct SentView: View {
    let onClose: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)

                Text(UserOrientStrings.sentTitle(languageCode: nil))
                    .font(.headline)

                Text(UserOrientStrings.sentDescription(languageCode: nil))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)

                Button(action: onClose) {
                    Text(UserOrientStrings.goBack(languageCode: nil))
                        .font(.headline)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.accentColor)
                        )
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct HideScrollContentBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

private func platformFormBackgroundColor() -> Color {
    #if canImport(UIKit)
    return Color(UIColor.systemBackground)
    #elseif canImport(AppKit)
    return Color(nsColor: .windowBackgroundColor)
    #else
    return Color.white
    #endif
}


