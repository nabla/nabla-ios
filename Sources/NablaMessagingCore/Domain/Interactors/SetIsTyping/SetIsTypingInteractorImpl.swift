import Foundation
import NablaCore

final class SetIsTypingInteractorImpl: AuthenticatedInteractor, SetIsTypingInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - SetIsTypingInteractor
    
    /// - Throws: ``NablaError``
    func execute(isTyping: Bool, conversationId: UUID) async throws {
        try assertIsAuthenticated()
        let transientId = repository.getConversationTransientId(from: conversationId)
        try await repository.setIsTyping(isTyping, conversationId: transientId)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
