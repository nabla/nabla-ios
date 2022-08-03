import Foundation

struct LocalTextMessageItem: LocalConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    let content: String
}
