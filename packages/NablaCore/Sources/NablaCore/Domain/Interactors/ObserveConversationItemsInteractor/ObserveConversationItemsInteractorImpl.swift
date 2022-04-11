import Foundation
import NablaUtils

class ObserveConversationItemsInteractorImpl: ObserveConversationItemsInteractor {
    // MARK: - Internal
    
    func execute(
        conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> Cancellable {
        conversationItemRespository.observeConversationItems(ofConversationWithId: conversationId, callback: callback)
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRespository: ConversationItemRepository
}
