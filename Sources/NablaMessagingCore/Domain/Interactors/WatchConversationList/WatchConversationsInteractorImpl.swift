import Foundation

class WatchConversationsInteractorImpl: AuthenticatedInteractor, WatchConversationsInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - WatchConversationsInteractor
    
    func execute(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher {
        guard isAuthenticated(handler: handler) else {
            return FailurePaginatedWatcher()
        }
        return repository.watchConversations(handler: handler)
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
