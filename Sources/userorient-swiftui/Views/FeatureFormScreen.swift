import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

struct FeatureFormScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FormViewModel()

    private var toolbarClosePlacement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarTrailing
        #else
        .cancellationAction
        #endif
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if !viewModel.isSent {
                    formBody
                        .frame(maxHeight: .infinity)
                }
                footer
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(UserOrientStrings.addFeature(languageCode: nil))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            #if os(macOS)
            .frame(minWidth: 520, minHeight: 420)
            #endif
            .toolbar {
                ToolbarItem(placement: toolbarClosePlacement) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
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
        VStack {
            TextEditor(text: $viewModel.text)
                .padding(8)
                .frame(maxWidth: .infinity, minHeight: 160, maxHeight: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary.opacity(0.3))
                )
                .padding(.horizontal, 16)
                .padding(.top, 8)
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
                    .padding(.trailing, 24)
                    .padding(.top, 4)
            }
        }
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

private func platformFormBackgroundColor() -> Color {
    #if canImport(UIKit)
    return Color(UIColor.systemBackground)
    #elseif canImport(AppKit)
    return Color(nsColor: .windowBackgroundColor)
    #else
    return Color.white
    #endif
}


