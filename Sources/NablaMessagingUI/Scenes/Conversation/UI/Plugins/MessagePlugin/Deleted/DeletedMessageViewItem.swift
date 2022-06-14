import Foundation
import NablaMessagingCore

struct DeletedMessageViewItem: ConversationViewMessageItem {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let replyTo: ConversationViewMessageItem?
    var isContiguous: Bool = false
    var isFocused: Bool = false
}

extension DeletedMessageViewItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(sender)
        hasher.combine(sendingState)
        hasher.combine(isContiguous)
        hasher.combine(isFocused)
    }

    static func == (lhs: DeletedMessageViewItem, rhs: DeletedMessageViewItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
