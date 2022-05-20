import Foundation

class WatchConversationInteractorImpl: AuthenticatedInteractor, WatchConversationInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - WatchConversationInteractor

    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        return repository.watchConversation(conversationId, handler: handler)
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
