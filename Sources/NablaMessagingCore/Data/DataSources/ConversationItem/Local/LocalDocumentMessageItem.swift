import Foundation

struct LocalDocumentMessageItem: LocalMediaConversationMessage {
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let replyToUuid: UUID?
    let content: LocalMediaMessageItemContent<DocumentFile>
    var isUploaded: Bool {
        content.uploadUuid != nil
    }
}
