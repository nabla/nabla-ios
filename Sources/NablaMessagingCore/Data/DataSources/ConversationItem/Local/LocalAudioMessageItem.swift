import Foundation

struct LocalAudioMessageItem: LocalMediaConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    var content: LocalMediaMessageItemContent<AudioFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
