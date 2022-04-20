import Foundation
import NablaUtils

final class SendMessageInteractorImpl: SendMessageInteractor {
    func execute(message: MessageInput, conversationId: UUID, callback: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        conversationItemRepository.sendMessage(message, conversationId: conversationId, callback: callback)
    }

    // MARK: - Private

    @Inject private var conversationItemRepository: ConversationItemRepository
}
