import Foundation
import NablaMessagingCore

struct DocumentMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: ConversationItemSender
    let state: ConversationItemState
    let document: Media
    var isContiguous: Bool = false
}
