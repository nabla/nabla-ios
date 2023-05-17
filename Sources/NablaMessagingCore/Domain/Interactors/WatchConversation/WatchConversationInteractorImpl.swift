import Combine
import Foundation
import NablaCore

class WatchConversationInteractorImpl: AuthenticatedInteractor, WatchConversationInteractor {
    // MARK: - Initializer
    
    init(
        userRepository: UserRepository,
        conversationRepository: ConversationRepository
    ) {
        self.conversationRepository = conversationRepository
        super.init(userRepository: userRepository)
    }
    
    // MARK: - WatchConversationInteractor
    
    func execute(_ conversationId: UUID) -> AnyPublisher<Response<Conversation>, NablaError> {
        let transientId = conversationRepository.getConversationTransientId(from: conversationId)
        return isAuthenticated
            .nabla.switchToLatest { [conversationRepository] in
                conversationRepository.watchConversation(withId: transientId)
            }
            .map { $0.asResponse() }
            .eraseToAnyPublisher()
    }
    
    // MARK: - private
    
    private let conversationRepository: ConversationRepository
}
