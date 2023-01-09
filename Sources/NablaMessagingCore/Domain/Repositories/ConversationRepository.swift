import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationRepository {
    func getConversationTransientId(from id: UUID) -> TransientUUID
    
    func watchConversation(withId conversationId: TransientUUID) -> AnyPublisher<Conversation, NablaError>
    
    func watchConversations() -> AnyPublisher<PaginatedList<Conversation>, NablaError>
    
    /// - Throws: ``NablaError``
    func createConversation(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?
    ) async throws -> Conversation
    
    func startConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation
    
    /// - Throws: ``NablaError``
    func setIsTyping(_ isTyping: Bool, conversationId: TransientUUID) async throws
    
    /// - Throws: ``NablaError``
    func markConversationAsSeen(conversationId: TransientUUID) async throws
}
