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

    func execute(
        message: MessageInput,
        replyToMessageId: UUID?,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        guard isMessageValid(message) else {
            handler(.failure(InvalidMessageError()))
            return Failure()
        }
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return itemsRepository.sendMessage(
            message,
            replyToMessageId: replyToMessageId,
            inConversationWithId: transientId,
            handler: handler
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
