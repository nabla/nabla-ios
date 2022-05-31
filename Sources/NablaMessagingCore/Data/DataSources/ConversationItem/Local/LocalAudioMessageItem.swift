import Foundation

struct LocalAudioMessageItem: LocalMediaConversationMessage {
    let clientId: UUID
    let date: Date
    var sendingState: ConversationMessageSendingState
    let content: LocalMediaMessageItemContent
}
