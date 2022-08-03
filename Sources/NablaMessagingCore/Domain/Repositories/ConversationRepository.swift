import Foundation
import NablaCore

protocol ConversationRepository {
    func getConversationTransientId(from id: UUID) -> TransientUUID
    
    func watchConversation(withId conversationId: TransientUUID, handler: ResultHandler<Conversation, NablaError>) -> Watcher
    
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher
    
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: GQL.SendMessageInput?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable
    
    func createDraftConversation(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
    
    func markConversationAsSeen(
        conversationId: TransientUUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
