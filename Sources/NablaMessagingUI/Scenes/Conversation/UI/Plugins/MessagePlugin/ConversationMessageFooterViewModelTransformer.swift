import Foundation

struct ConversationMessageFooterViewModelTransformer {
    // MARK: - Public

    static func transform(item: ConversationViewMessageItem) -> ConversationMessageFooterViewModel? {
        switch item.sendingState {
        case .sending:
            return .init(text: L10n.conversationMessageStatusSending, color: .lightGray)
        case .sent where item.isFocused:
            return .init(text: L10n.conversationMessageStatusSent, color: .lightGray)
        case .sent, .toBeSent:
            return nil
        case .failed:
            return .init(text: L10n.conversationMessageStatusFailed, color: .red)
        }
    }
}
