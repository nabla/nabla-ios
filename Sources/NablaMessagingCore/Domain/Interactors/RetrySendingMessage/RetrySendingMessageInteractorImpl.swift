import Foundation
import NablaUtils

final class RetrySendingMessageInteractorImpl: AuthenticatedInteractor, RetrySendingMessageInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationItemRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - RetrySendingMessageInteractor

    func execute(
        itemId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        return repository.retrySending(itemWithId: itemId, inConversationWithId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
