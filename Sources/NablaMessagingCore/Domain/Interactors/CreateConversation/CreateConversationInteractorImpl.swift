import Foundation
import NablaUtils

final class CreateConversationInteractorImpl: AuthenticatedInteractor, CreateConversationInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - Internal
    
    func execute(handler: ResultHandler<Conversation, NablaError>) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        return repository.createConversation(handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
