import Foundation

protocol WatchConversationInteractor {
    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaWatchConversationError>) -> Cancellable
}
