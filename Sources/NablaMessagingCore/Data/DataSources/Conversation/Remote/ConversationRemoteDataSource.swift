import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationRemoteDataSource {
    func createConversation(
        message: GQL.SendMessageInput?,
        title: String?,
        providerIds: [UUID]?,
        handler: ResultHandler<RemoteConversation, GQLError>
    ) -> NablaCancellable
    
    /// - Throws: ``GQLError``
    func setIsTyping(_ isTyping: Bool, conversationId: UUID) async throws
    
    /// - Throws: ``GQLError``
    func markConversationAsSeen(conversationId: UUID) async throws
    
    func watchConversation(_ conversationId: UUID, handler: ResultHandler<RemoteConversation, GQLError>) -> Watcher
    
    func watchConversations(handler: ResultHandler<RemoteConversationList, GQLError>) -> PaginatedWatcher
    
    func subscribeToConversationsEvents(
        handler: ResultHandler<RemoteConversationsEvent, GQLError>
    ) -> NablaCancellable
}
