import Foundation
import NablaMessagingCore

struct TextMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: ConversationItemSender
    let state: ConversationItemState
    let text: String
    var isContiguous: Bool = false
}
