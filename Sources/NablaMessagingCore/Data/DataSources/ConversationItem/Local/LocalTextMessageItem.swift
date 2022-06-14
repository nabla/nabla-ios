import Foundation

struct LocalTextMessageItem: LocalConversationMessage {
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    let content: String
}
