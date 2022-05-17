import Foundation
import NablaUtils

class WatchConversationItemsInteractorImpl: WatchConversationItemsInteractor {
    // MARK: - Internal
    
    func execute(
        conversationId: UUID,
        handler: ResultHandler<ConversationItems, NablaWatchConversationItemsError>
    ) -> PaginatedWatcher {
        conversationItemRepository.watchConversationItems(ofConversationWithId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRepository: ConversationItemRepository
}
