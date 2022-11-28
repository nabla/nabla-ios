import Foundation
import NablaCore

protocol ConversationRepository {
    func getConversationTransientId(from id: UUID) -> TransientUUID
    
    func watchConversation(withId conversationId: TransientUUID, handler: ResultHandler<Conversation, NablaError>) -> Watcher
    
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher
    
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: MessageInput?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> NablaCancellable
    
    func createDraftConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation
    
    /// - Throws: ``NablaError``
    func setIsTyping(_ isTyping: Bool, conversationId: TransientUUID) async throws
    
    /// - Throws: ``NablaError``
    func markConversationAsSeen(conversationId: TransientUUID) async throws
}
