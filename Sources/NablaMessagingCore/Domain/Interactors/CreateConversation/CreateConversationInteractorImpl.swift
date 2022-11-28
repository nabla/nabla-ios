import Foundation
import NablaCore

final class CreateConversationInteractorImpl: AuthenticatedInteractor, CreateConversationInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - Internal
    
    func execute(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: MessageInput?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> NablaCancellable {
        guard isAuthenticated else {
            return Failure(handler: handler, error: MissingAuthenticationProviderError())
        }
        return repository.createConversation(
            title: title,
            providerIds: providerIds,
            initialMessage: initialMessage,
            handler: handler
        )
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
