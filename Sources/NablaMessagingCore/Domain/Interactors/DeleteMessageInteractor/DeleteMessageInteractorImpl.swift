import Foundation
import NablaUtils

final class DeleteMessageInteractorImpl: DeleteMessageInteractor {
    // MARK: - Initializer

    init(conversationItemRepository: ConversationItemRepository) {
        repository = conversationItemRepository
    }

    // MARK: - DeleteMessageInteractor

    func execute(
        messageId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaDeleteMessageError>
    ) -> Cancellable {
        repository.deleteMessage(
            withId: messageId,
            conversationId: conversationId,
            handler: handler
        )
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
