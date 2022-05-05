import Foundation

protocol LocalConversationMessage: LocalConversationItem {
    var sendingState: ConversationMessageSendingState { get set }
}
