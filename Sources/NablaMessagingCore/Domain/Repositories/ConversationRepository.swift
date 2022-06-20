import Foundation

protocol ConversationRepository {
    func watchConversation(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Cancellable
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher
    func createConversation(
        title: String?,
        providerIdToAssign: UUID?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable
}
