import Foundation

struct LocalImageMessageItem: LocalMediaConversationMessage {
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let content: LocalMediaMessageItemContent
}
