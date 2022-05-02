import Foundation
import NablaMessagingCore

struct DeletedMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: ConversationItemSender
    let state: ConversationItemState
    var isContiguous: Bool = false
}