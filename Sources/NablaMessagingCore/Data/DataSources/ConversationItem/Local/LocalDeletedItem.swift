import Foundation

struct LocalDeletedMessageItem: LocalConversationItem {
    let clientId: UUID
    let date: Date
    let sender: ConversationItemSender
    var state: ConversationItemState = .sent
}
