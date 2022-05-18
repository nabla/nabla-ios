import Foundation
import NablaUtils

final class RetrySendingMessageInteractorImpl: RetrySendingMessageInteractor {
    // MARK: - Initializer

    init(conversationItemRepository: ConversationItemRepository) {
        repository = conversationItemRepository
    }

    // MARK: - RetrySendingMessageInteractor

    func execute(
        itemId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaRetrySendingMessageError>
    ) -> Cancellable {
        repository.retrySending(itemWithId: itemId, inConversationWithId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
