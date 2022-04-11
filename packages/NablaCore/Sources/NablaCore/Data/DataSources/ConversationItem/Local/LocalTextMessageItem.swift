import Foundation

struct LocalTextMessageItem: LocalConversationItem {
    let id: UUID
    let clientId: UUID
    let date: Date
    let sender: ConversationItemSender
    var state: ConversationItemState
    let content: String
}
