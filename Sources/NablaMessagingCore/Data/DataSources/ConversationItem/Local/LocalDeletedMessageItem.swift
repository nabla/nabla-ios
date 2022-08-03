import Foundation

struct LocalDeletedMessageItem: LocalConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    let sender: ConversationMessageSender
    var sendingState: ConversationMessageSendingState = .sent
    let replyToUuid: UUID?
}
