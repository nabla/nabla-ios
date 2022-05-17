import Foundation

protocol ConversationRepository {
    func watchConversation(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaWatchConversationError>) -> Cancellable
    func watchConversations(handler: ResultHandler<ConversationList, NablaWatchConversationsError>) -> PaginatedWatcher
    func createConversation(handler: ResultHandler<Conversation, NablaCreateConversationError>) -> Cancellable
}
