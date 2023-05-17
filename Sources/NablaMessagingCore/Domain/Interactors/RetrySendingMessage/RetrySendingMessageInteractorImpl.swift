import Foundation
import NablaCore

final class RetrySendingMessageInteractorImpl: AuthenticatedInteractor, RetrySendingMessageInteractor {
    // MARK: - Initializer

    init(
        userRepository: UserRepository,
        itemsRepository: ConversationItemRepository,
        conversationsRepository: ConversationRepository
    ) {
        self.itemsRepository = itemsRepository
        self.conversationsRepository = conversationsRepository
        super.init(userRepository: userRepository)
    }

    // MARK: - RetrySendingMessageInteractor
    
    /// - Throws: ``NablaError``
    func execute(
        itemId: UUID,
        conversationId: UUID
    ) async throws {
        try assertIsAuthenticated()
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        try await itemsRepository.retrySending(itemWithId: itemId, inConversationWithId: transientId)
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
}
