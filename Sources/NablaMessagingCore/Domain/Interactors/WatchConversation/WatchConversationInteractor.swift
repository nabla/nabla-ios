import Foundation

protocol WatchConversationInteractor {
    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Cancellable
}
