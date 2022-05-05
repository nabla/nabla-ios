import Foundation

struct LocalDeletedMessageItem: LocalConversationItem {
    let clientId: UUID
    let date: Date
    var state: ConversationItemState = .sent
}
