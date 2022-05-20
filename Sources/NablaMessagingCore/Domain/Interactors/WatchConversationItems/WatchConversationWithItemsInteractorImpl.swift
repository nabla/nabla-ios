import Foundation

class WatchConversationItemsInteractorImpl: AuthenticatedInteractor, WatchConversationItemsInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationItemRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - Internal
    
    func execute(
        conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaError>
    ) -> PaginatedWatcher {
        guard isAuthenticated(handler: handler) else {
            return FailurePaginatedWatcher()
        }
        return repository.watchConversationItems(ofConversationWithId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
