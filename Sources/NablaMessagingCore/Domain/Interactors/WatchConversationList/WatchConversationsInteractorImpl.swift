import Combine
import Foundation
import NablaCore

class WatchConversationsInteractorImpl: AuthenticatedInteractor, WatchConversationsInteractor {
    // MARK: - Initializer

    init(
        userRepository: UserRepository,
        conversationRepository: ConversationRepository
    ) {
        self.conversationRepository = conversationRepository
        super.init(userRepository: userRepository)
    }

    // MARK: - WatchConversationsInteractor
    
    func execute() -> AnyPublisher<Response<PaginatedList<Conversation>>, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [conversationRepository] in
                conversationRepository.watchConversations()
            }
            .map { $0.asResponse() }
            .eraseToAnyPublisher()
    }
    
    // MARK: - private
    
    private let conversationRepository: ConversationRepository
}
