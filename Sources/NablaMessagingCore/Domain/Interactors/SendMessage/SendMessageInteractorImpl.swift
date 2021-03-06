import Foundation
import NablaCore

final class SendMessageInteractorImpl: AuthenticatedInteractor, SendMessageInteractor {
    // MARK: - Initializer

    init(authenticator: Authenticator, repository: ConversationItemRepository) {
        self.repository = repository
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
        return repository.sendMessage(
            message,
            replyToMessageId: replyToMessageId,
            inConversationWithId: conversationId,
            handler: handler
        )
    }
    
    // MARK: - Private

    private let repository: ConversationItemRepository

    private func isMessageValid(_ message: MessageInput) -> Bool {
        switch message {
        case let .text(content):
            return !content.isEmpty
        case .document, .image, .audio, .video:
            return true
        }
    }
}
