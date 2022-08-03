import Foundation
import NablaCore

class WatchConversationInteractorImpl: AuthenticatedInteractor, WatchConversationInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - WatchConversationInteractor

    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Watcher {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        let transientId = repository.getConversationTransientId(from: conversationId)
        return repository.watchConversation(withId: transientId, handler: handler)
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
