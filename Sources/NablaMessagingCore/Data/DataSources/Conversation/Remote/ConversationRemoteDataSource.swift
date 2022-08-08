import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConversationRemoteDataSource {
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: GQL.SendMessageInput?,
        handler: ResultHandler<RemoteConversation, GQLError>
    ) -> Cancellable
    
    func setIsTyping(
        _ isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
    
    func markConversationAsSeen(
        conversationId: UUID,
        handler: ResultHandler<Void, GQLError>
    ) -> Cancellable
    
    func watchConversation(_ conversationId: UUID, handler: ResultHandler<RemoteConversation, GQLError>) -> Watcher
    
    func watchConversations(handler: ResultHandler<RemoteConversationList, GQLError>) -> PaginatedWatcher
    
    func subscribeToConversationsEvents(
        handler: ResultHandler<RemoteConversationsEvent, GQLError>
    ) -> Cancellable
}
