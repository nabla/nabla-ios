import Foundation

struct LocalDocumentMessageItem: LocalConversationItem {
    let clientId: UUID
    let date: Date
    let sender: ConversationItemSender
    var state: ConversationItemState
    let content: UploadedMedia
}
