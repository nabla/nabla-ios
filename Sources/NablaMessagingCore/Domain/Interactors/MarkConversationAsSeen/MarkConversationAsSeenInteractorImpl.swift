import Foundation
import NablaUtils

final class MarkConversationAsSeenInteractorImpl: AuthenticatedInteractor, MarkConversationAsSeenInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationItemRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - MarkConversationAsSeenInteractor

    func execute(
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        return repository.markConversationAsSeen(conversationId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
