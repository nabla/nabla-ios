import Foundation
import NablaCore

final class SendMessageInteractorImpl: AuthenticatedInteractor, SendMessageInteractor {
    // MARK: - Initializer

    init(
        authenticator: Authenticator,
        itemsRepository: ConversationItemRepository,
        conversationsRepository: ConversationRepository
    ) {
        self.itemsRepository = itemsRepository
        self.conversationsRepository = conversationsRepository
        super.init(authenticator: authenticator)
    }

    // MARK: - SendMessageInteractor

    /// - Throws: ``NablaError``
    func execute(
        message: MessageInput,
        replyToMessageId: UUID?,
        conversationId: UUID
    ) async throws {
        guard isAuthenticated else {
            throw MissingAuthenticationProviderError()
        }
        guard isMessageValid(message) else {
            throw InvalidMessageError()
        }
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        try await itemsRepository.sendMessage(
            message,
            replyToMessageId: replyToMessageId,
            inConversationWithId: transientId
        )
    }
    
    // MARK: - Private

    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository

    private func isMessageValid(_ message: MessageInput) -> Bool {
        switch message {
        case let .text(content):
            return !content.isEmpty
        case .document, .image, .audio, .video:
            return true
        }
    }
}
