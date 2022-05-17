import Foundation
import NablaUtils

final class RetrySendingMessageInteractorImpl: RetrySendingMessageInteractor {
    func execute(
        itemId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaRetrySendingMessageError>
    ) -> Cancellable {
        repository.retrySending(itemWithId: itemId, inConversationWithId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    @Inject private var repository: ConversationItemRepository
}
