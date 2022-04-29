import Foundation
import NablaUtils

class WatchConversationWithItemsInteractorImpl: WatchConversationWithItemsInteractor {
    // MARK: - Internal
    
    func execute(
        conversationId: UUID,
        callback: @escaping (Result<ConversationWithItems, Error>) -> Void
    ) -> PaginatedWatcher {
        conversationItemRepository.watchConversationItems(ofConversationWithId: conversationId, callback: callback)
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRepository: ConversationItemRepository
}
