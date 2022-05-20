import Foundation

final class DeleteMessageInteractorImpl: AuthenticatedInteractor, DeleteMessageInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationItemRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - DeleteMessageInteractor

    func execute(
        messageId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        return repository.deleteMessage(
            withId: messageId,
            conversationId: conversationId,
            handler: handler
        )
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
