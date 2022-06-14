import Foundation

public struct AudioMessageItem: ConversationMessage {
    public let id: UUID
    public let date: Date
    public let sender: ConversationMessageSender
    public let sendingState: ConversationMessageSendingState
    public let replyTo: ConversationMessage?
    public let content: AudioFile
}
