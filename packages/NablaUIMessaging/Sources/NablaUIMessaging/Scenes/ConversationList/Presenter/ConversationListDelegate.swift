import Foundation
import NablaCore

public protocol ConversationListDelegate: AnyObject {
    func conversationList(didSelect conversation: Conversation)
}
