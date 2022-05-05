import Foundation
import NablaMessagingCore

struct ImageMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let image: Media
    var isContiguous: Bool = false
}
