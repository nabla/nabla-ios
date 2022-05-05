import Foundation

struct LocalDocumentMessageItem: LocalMediaConversationItem {
    let clientId: UUID
    let date: Date
    var state: ConversationItemState
    let content: LocalMediaMessageItemContent
}
