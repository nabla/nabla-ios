import Foundation

struct LocalDeletedMessageItem: LocalConversationMessage {
    let clientId: UUID
    let date: Date
    let sender: ConversationMessageSender
    var sendingState: ConversationMessageSendingState = .sent
    let replyToUuid: UUID?
}
