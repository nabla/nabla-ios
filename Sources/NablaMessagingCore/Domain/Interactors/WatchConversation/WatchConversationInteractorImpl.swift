import Combine
import Foundation
import NablaCore

class WatchConversationInteractorImpl: AuthenticatedInteractor, WatchConversationInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - WatchConversationInteractor

    func execute(_ conversationId: UUID) -> AnyPublisher<Response<Conversation>, NablaError> {
        guard isAuthenticated else {
            return Fail(error: MissingAuthenticationProviderError()).eraseToAnyPublisher()
        }
        let transientId = repository.getConversationTransientId(from: conversationId)
        return repository.watchConversation(withId: transientId)
            .map { $0.asResponse() }
            .eraseToAnyPublisher()
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
