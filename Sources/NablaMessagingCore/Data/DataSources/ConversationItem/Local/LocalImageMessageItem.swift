import Foundation

struct LocalImageMessageItem: LocalMediaConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    let content: LocalMediaMessageItemContent<ImageFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
