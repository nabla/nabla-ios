import Foundation
import NablaUtils

final class RetrySendingMessageInteractorImpl: RetrySendingMessageInteractor {
    func execute(
        itemId: UUID,
        conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable {
        repository.retrySending(itemWithId: itemId, inConversationWithId: conversationId, completion: completion)
    }
    
    // MARK: - Private
    
    @Inject private var repository: ConversationItemRepository
}
