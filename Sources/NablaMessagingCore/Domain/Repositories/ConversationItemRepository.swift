import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationItemRepository {
    func watchConversationItems(
        ofConversationWithId: TransientUUID
    ) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError>
    
    /// - Throws: ``NablaError``
    func sendMessage(
        _ message: MessageInput,
        replyToMessageId: UUID?,
        inConversationWithId: TransientUUID
    ) async throws
    
    /// - Throws: ``NablaError``
    func retrySending(
        itemWithId itemId: UUID,
        inConversationWithId: TransientUUID
    ) async throws
    
    /// - Throws: ``NablaError``
    func deleteMessage(withId messageId: UUID, conversationId: TransientUUID) async throws
}
