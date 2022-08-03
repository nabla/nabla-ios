import Foundation
import NablaCore

class WatchConversationItemsInteractorImpl: AuthenticatedInteractor, WatchConversationItemsInteractor {
    // MARK: - Initializer

    init(
        authenticator: Authenticator,
        itemsRepository: ConversationItemRepository,
        conversationsRepository: ConversationRepository
    ) {
        self.itemsRepository = itemsRepository
        self.conversationsRepository = conversationsRepository
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
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return itemsRepository.watchConversationItems(ofConversationWithId: transientId, handler: handler)
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
}
