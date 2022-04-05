import Foundation

public protocol ConversationListDelegate: AnyObject {
    func conversationList(didSelectConversationWithId conversationId: UUID)
}
