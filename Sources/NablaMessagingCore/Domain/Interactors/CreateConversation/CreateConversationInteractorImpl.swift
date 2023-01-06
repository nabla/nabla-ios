import Foundation
import NablaCore

final class CreateConversationInteractorImpl: AuthenticatedInteractor, CreateConversationInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationRepository) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }

    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?
    ) async throws -> Conversation {
        guard isAuthenticated else {
            throw MissingAuthenticationProviderError()
        }
        return try await repository.createConversation(
            message: message,
            title: title,
            providerIds: providerIds
        )
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
