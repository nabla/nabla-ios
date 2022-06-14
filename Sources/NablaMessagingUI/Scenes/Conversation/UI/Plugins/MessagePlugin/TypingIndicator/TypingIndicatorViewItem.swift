import Foundation
import NablaMessagingCore

struct TypingIndicatorViewItem: ConversationViewMessageItem {
    let id: UUID = .init()
    let date: Date = .init()
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState = .sent
    let replyTo: ConversationViewMessageItem? = nil
    var isContiguous: Bool = false
    var isFocused: Bool = false
}

extension TypingIndicatorViewItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(sender)
        hasher.combine(sendingState)
        hasher.combine(isContiguous)
        hasher.combine(isFocused)
    }

    static func == (lhs: TypingIndicatorViewItem, rhs: TypingIndicatorViewItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
