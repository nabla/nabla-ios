import Foundation
import NablaCore

final class SetIsTypingInteractorImpl: AuthenticatedInteractor, SetIsTypingInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationItemRepository) {
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
        return repository.setIsTyping(isTyping, conversationId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
