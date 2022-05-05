import Foundation
import NablaUtils

class WatchConversationItemsInteractorImpl: WatchConversationItemsInteractor {
    // MARK: - Internal
    
    func execute(
        conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> PaginatedWatcher {
        conversationItemRepository.watchConversationItems(ofConversationWithId: conversationId, callback: callback)
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRepository: ConversationItemRepository
}
