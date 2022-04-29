import Foundation
import NablaMessagingCore

public protocol ConversationListDelegate: AnyObject {
    func conversationList(didSelect conversation: Conversation)
}
