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
    
    func execute() -> AnyPublisher<Response<PaginatedList<Conversation>>, NablaError> {
        isAuthenticated
            .map { [repository] in
                repository.watchConversations()
            }
            .switchToLatest()
            .map { $0.asResponse() }
            .eraseToAnyPublisher()
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
