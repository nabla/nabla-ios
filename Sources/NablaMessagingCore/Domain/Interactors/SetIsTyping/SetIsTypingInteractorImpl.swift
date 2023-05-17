import Foundation
import NablaCore

final class SetIsTypingInteractorImpl: AuthenticatedInteractor, SetIsTypingInteractor {
    // MARK: - Initializer

    init(
        userRepository: UserRepository,
        conversationRepository: ConversationRepository
    ) {
        self.conversationRepository = conversationRepository
        super.init(userRepository: userRepository)
    }

    // MARK: - SetIsTypingInteractor
    
    /// - Throws: ``NablaError``
    func execute(isTyping: Bool, conversationId: UUID) async throws {
        try assertIsAuthenticated()
        let transientId = conversationRepository.getConversationTransientId(from: conversationId)
        try await conversationRepository.setIsTyping(isTyping, conversationId: transientId)
    }
    
    // MARK: - Private
    
    private let conversationRepository: ConversationRepository
}
