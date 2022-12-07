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
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> NablaCancellable {
        guard isAuthenticated else {
            return Failure(handler: handler, error: MissingAuthenticationProviderError())
        }
        return repository.createConversation(
            message: message,
            title: title,
            providerIds: providerIds,
            handler: handler
        )
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
