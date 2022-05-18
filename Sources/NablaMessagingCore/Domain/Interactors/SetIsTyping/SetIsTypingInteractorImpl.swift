import Foundation
import NablaUtils

final class SetIsTypingInteractorImpl: SetIsTypingInteractor {
    // MARK: - Initializer

    init(conversationItemRepository: ConversationItemRepository) {
        repository = conversationItemRepository
    }

    // MARK: - SetIsTypingInteractor

    func execute(
        isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSetIsTypingError>
    ) -> Cancellable {
        repository.setIsTyping(isTyping, conversationId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
