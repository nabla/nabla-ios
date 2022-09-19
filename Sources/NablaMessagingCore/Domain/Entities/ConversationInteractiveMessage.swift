import Foundation

public protocol ConversationInteractiveMessage: ConversationItem {
    var sender: ConversationMessageSender { get }
}
