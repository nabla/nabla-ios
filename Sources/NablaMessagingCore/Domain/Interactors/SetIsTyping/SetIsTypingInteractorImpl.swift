import Foundation
import NablaUtils

final class SetIsTypingInteractorImpl: SetIsTypingInteractor {
    func execute(
        isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSetIsTypingError>
    ) -> Cancellable {
        conversationItemRepository.setIsTyping(isTyping, conversationId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRepository: ConversationItemRepository
}
