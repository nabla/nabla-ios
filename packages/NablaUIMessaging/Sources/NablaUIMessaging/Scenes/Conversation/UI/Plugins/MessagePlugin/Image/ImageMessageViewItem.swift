import Foundation
import NablaCore

struct ImageMessageViewItem: ConversationViewMessageItem, Hashable {
    let id: UUID
    let date: Date
    let sender: ConversationItemSender
    let state: ConversationItemState
    let image: Media
}
