import Foundation

struct LocalImageMessageItem: LocalMediaConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    var content: LocalMediaMessageItemContent<ImageFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
