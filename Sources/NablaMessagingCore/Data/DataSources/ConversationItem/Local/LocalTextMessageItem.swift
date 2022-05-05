import Foundation

struct LocalTextMessageItem: LocalConversationMessage {
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let content: String
}
