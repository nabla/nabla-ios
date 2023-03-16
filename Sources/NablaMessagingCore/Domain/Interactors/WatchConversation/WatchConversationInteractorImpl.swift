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
        let transientId = repository.getConversationTransientId(from: conversationId)
        return isAuthenticated
            .nabla.switchToLatest { [repository] in
                repository.watchConversation(withId: transientId)
            }
            .map { $0.asResponse() }
            .eraseToAnyPublisher()
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
