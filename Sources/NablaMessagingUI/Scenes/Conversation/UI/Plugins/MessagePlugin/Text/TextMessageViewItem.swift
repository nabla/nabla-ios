import Foundation
import NablaMessagingCore

struct TextMessageViewItem: ConversationViewMessageItem {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let replyTo: ConversationViewMessageItem?
    let text: String
    var isContiguous: Bool = false
    var isFocused: Bool = false
}

extension TextMessageViewItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(sender)
        hasher.combine(sendingState)
        hasher.combine(text)
        hasher.combine(isContiguous)
        hasher.combine(isFocused)
    }

    static func == (lhs: TextMessageViewItem, rhs: TextMessageViewItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
