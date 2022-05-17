import Foundation
import NablaUtils

final class DeleteMessageInteractorImpl: DeleteMessageInteractor {
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
    
    @Inject private var repository: ConversationItemRepository
}
