import Foundation
import NablaCore

final class MarkConversationAsSeenInteractorImpl: AuthenticatedInteractor, MarkConversationAsSeenInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
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
        let transientId = repository.getConversationTransientId(from: conversationId)
        return repository.markConversationAsSeen(conversationId: transientId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
