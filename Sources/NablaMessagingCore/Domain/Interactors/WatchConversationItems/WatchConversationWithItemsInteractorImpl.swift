import Combine
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
    
    func execute(conversationId: UUID) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError> {
        guard isAuthenticated else {
            return Fail(error: MissingAuthenticationProviderError()).eraseToAnyPublisher()
        }
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return itemsRepository.watchConversationItems(ofConversationWithId: transientId)
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
}
