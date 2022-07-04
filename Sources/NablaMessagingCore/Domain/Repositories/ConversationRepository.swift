import Foundation
import NablaCore

protocol ConversationRepository {
    func watchConversation(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Watcher
    func watchConversations(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher
    func createConversation(
        title: String?,
        providerIds: [UUID]?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable
}
