import Foundation

struct LocalImageMessageItem: LocalMediaConversationItem {
    let clientId: UUID
    let date: Date
    var state: ConversationItemState
    let content: LocalMediaMessageItemContent
}
