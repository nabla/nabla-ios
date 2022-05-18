import Foundation
import NablaUtils

class WatchConversationItemsInteractorImpl: WatchConversationItemsInteractor {
    // MARK: - Initializer

    init(conversationItemRepository: ConversationItemRepository) {
        repository = conversationItemRepository
    }

    // MARK: - Internal
    
    func execute(
        conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaWatchConversationItemsError>
    ) -> PaginatedWatcher {
        repository.watchConversationItems(ofConversationWithId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
