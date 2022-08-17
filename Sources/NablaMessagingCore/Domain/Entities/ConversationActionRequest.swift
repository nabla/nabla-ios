import Foundation

public protocol ConversationActionRequest: ConversationItem {
    var sender: ConversationMessageSender { get }
}
