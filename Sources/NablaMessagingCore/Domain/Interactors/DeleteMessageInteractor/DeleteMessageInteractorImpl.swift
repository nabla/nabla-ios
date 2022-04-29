import Foundation
import NablaUtils

final class DeleteMessageInteractorImpl: DeleteMessageInteractor {
    func execute(messageId: UUID, conversationId: UUID, callback: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        repository.deleteMessage(withId: messageId, conversationId: conversationId, callback: callback)
    }
    
    // MARK: - Private
    
    @Inject private var repository: ConversationItemRepository
}
