import Foundation

struct LocalVideoMessageItem: LocalMediaConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    var content: LocalMediaMessageItemContent<VideoFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
