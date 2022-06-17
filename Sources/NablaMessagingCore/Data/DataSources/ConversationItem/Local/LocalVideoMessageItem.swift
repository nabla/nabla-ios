import Foundation

struct LocalVideoMessageItem: LocalMediaConversationMessage {
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    let content: LocalMediaMessageItemContent<VideoFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
