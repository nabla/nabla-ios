import Foundation
import NablaMessagingCore

struct DocumentMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let document: Media
    var isContiguous: Bool = false
    var isFocused: Bool = false
}
