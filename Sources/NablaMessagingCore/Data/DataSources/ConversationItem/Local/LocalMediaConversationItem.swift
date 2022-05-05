import Foundation

protocol LocalMediaConversationMessage: LocalConversationMessage {
    var content: LocalMediaMessageItemContent { get }
}
