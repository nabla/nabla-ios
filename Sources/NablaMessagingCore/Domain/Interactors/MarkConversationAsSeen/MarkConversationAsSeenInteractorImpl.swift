import Foundation
import NablaCore

final class MarkConversationAsSeenInteractorImpl: AuthenticatedInteractor, MarkConversationAsSeenInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - MarkConversationAsSeenInteractor

    /// - Throws: ``NablaError``
    func execute(conversationId: UUID) async throws {
        guard isAuthenticated else {
            throw MissingAuthenticationProviderError()
        }
        let transientId = repository.getConversationTransientId(from: conversationId)
        try await repository.markConversationAsSeen(conversationId: transientId)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
