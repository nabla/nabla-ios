import Foundation

public struct TextMessageItem: ConversationMessage {
    public let id: UUID
    public let date: Date
    public let sender: ConversationMessageSender
    public let sendingState: ConversationMessageSendingState
    public let content: String
}
