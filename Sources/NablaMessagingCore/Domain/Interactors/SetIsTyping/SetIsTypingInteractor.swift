import Foundation

protocol SetIsTypingInteractor {
    func execute(
        isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSetIsTypingError>
    ) -> Cancellable
}
