import Foundation

protocol ConversationRepository {
    func watchConversation(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Cancellable
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher
    func createConversation(handler: ResultHandler<Conversation, NablaError>) -> Cancellable
}
