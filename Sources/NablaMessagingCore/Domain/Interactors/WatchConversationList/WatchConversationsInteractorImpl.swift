import Combine
import Foundation
import NablaCore

class WatchConversationsInteractorImpl: AuthenticatedInteractor, WatchConversationsInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - WatchConversationsInteractor
    
    func execute() -> AnyPublisher<PaginatedList<Conversation>, NablaError> {
        guard isAuthenticated else {
            return Fail(error: MissingAuthenticationProviderError()).eraseToAnyPublisher()
        }
        return repository.watchConversations()
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
