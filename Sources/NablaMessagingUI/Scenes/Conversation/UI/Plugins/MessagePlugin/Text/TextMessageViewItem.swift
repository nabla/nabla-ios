import Foundation
import NablaMessagingCore

struct TextMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: NablaMessagingCore.ConversationMessageSender
    let sendingState: ConversationMessageSendingState
    let text: String
    var isContiguous: Bool = false
    var isFocused: Bool = false
}
