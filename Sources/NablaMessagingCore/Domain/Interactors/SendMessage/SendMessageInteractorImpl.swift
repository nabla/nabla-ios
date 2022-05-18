import Foundation
import NablaUtils

final class SendMessageInteractorImpl: SendMessageInteractor {
    // MARK: - Initializer

    init(conversationItemRepository: ConversationItemRepository) {
        repository = conversationItemRepository
    }

    // MARK: - SendMessageInteractor

    func execute(
        message: MessageInput,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> Cancellable {
        guard isMessageValid(message) else {
            handler(.failure(.invalidMessage))
            return Failure()
        }
        return repository.sendMessage(
            message,
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
        case .document, .image:
            return true
        }
    }
}
