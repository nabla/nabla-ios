import Foundation
import NablaUtils

final class SendMessageInteractorImpl: SendMessageInteractor {
    func execute(message: MessageInput, conversationId: UUID, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable {
        conversationItemRepository.sendMessage(message, inConversationWithId: conversationId, completion: completion)
    }

    // MARK: - Private

    @Inject private var conversationItemRepository: ConversationItemRepository
}
