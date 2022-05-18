import Foundation
import NablaUtils

class WatchConversationInteractorImpl: WatchConversationInteractor {
    // MARK: - Initializer

    init(conversationRepository: ConversationRepository) {
        repository = conversationRepository
    }

    // MARK: - WatchConversationInteractor

    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaWatchConversationError>) -> Cancellable {
        repository.watchConversation(conversationId, handler: handler)
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
