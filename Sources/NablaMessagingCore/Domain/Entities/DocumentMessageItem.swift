import Foundation

public struct DocumentMessageItem: ConversationMessage {
    public let id: UUID
    public let date: Date
    public let sender: ConversationMessageSender
    public let sendingState: ConversationMessageSendingState
    public let replyTo: ConversationMessage?
    public let content: Media
}
