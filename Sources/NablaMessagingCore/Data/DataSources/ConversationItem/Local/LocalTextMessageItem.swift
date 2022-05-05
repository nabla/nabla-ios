import Foundation

struct LocalTextMessageItem: LocalConversationItem {
    let clientId: UUID
    let date: Date
    var state: ConversationItemState
    let content: String
}
