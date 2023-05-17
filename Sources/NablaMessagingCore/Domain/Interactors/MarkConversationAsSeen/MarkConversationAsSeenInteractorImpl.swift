import Foundation
import NablaCore

final class MarkConversationAsSeenInteractorImpl: AuthenticatedInteractor, MarkConversationAsSeenInteractor {
    // MARK: - Initializer

    init(
        userRepository: UserRepository,
        conversationRepository: ConversationRepository
    ) {
        self.conversationRepository = conversationRepository
        super.init(userRepository: userRepository)
    }

    // MARK: - MarkConversationAsSeenInteractor

    /// - Throws: ``NablaError``
    func execute(conversationId: UUID) async throws {
        try assertIsAuthenticated()
        let transientId = conversationRepository.getConversationTransientId(from: conversationId)
        try await conversationRepository.markConversationAsSeen(conversationId: transientId)
    }
    
    // MARK: - Private
    
    private let conversationRepository: ConversationRepository
}
