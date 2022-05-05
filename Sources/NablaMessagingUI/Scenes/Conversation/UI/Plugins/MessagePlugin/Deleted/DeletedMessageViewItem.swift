import Foundation
import NablaMessagingCore

struct DeletedMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    var isContiguous: Bool = false
}
