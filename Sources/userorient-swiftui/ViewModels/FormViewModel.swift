import Foundation

@MainActor
final class FormViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isSubmitting = false
    @Published var errorMessage: String?
    @Published var isSent = false

    private let minLength = 10
    private let maxLength = 500

    var characterCount: Int {
        text.trimmingCharacters(in: .whitespacesAndNewlines).count
    }

    var isValid: Bool {
        let count = characterCount
        return count >= minLength && count <= maxLength
    }

    func submit() async {
        guard !isSubmitting, isValid else { return }

        isSubmitting = true
        errorMessage = nil

        do {
            let content = text.trimmingCharacters(in: .whitespacesAndNewlines)
            try await UserOrientClient.shared.submitFeatureRequest(content: content)
            isSent = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isSubmitting = false
    }
}

