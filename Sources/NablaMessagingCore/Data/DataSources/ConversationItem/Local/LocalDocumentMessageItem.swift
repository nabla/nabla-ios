import Foundation

struct LocalDocumentMessageItem: LocalMediaConversationMessage {
    let conversationId: UUID
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    var content: LocalMediaMessageItemContent<DocumentFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
