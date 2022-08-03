import Foundation
import NablaCore

final class SetIsTypingInteractorImpl: AuthenticatedInteractor, SetIsTypingInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - SetIsTypingInteractor

    func execute(
        isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        let transientId = repository.getConversationTransientId(from: conversationId)
        return repository.setIsTyping(isTyping, conversationId: transientId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
