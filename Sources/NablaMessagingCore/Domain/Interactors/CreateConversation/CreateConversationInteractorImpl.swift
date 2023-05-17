import Foundation
import NablaCore

final class CreateConversationInteractorImpl: AuthenticatedInteractor, CreateConversationInteractor {
    // MARK: - Initializer

    init(
        userRepository: UserRepository,
        conversationRepository: ConversationRepository
    ) {
        self.conversationRepository = conversationRepository
        super.init(userRepository: userRepository)
    }

    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?
    ) async throws -> Conversation {
        try assertIsAuthenticated()
        return try await conversationRepository.createConversation(
            message: message,
            title: title,
            providerIds: providerIds
        )
    }
    
    // MARK: - Private
    
    private let conversationRepository: ConversationRepository
}
