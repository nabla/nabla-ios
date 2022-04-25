import Foundation
import NablaUtils

final class SetIsTypingInteractorImpl: SetIsTypingInteractor {
    func execute(isTyping: Bool, conversationId: UUID) -> Cancellable {
        conversationItemRepository.setIsTyping(isTyping, conversationId: conversationId)
    }

    // MARK: - Private

    @Inject private var conversationItemRepository: ConversationItemRepository
}
