import Foundation

protocol SetIsTypingInteractor {
    func execute(isTyping: Bool, conversationId: UUID) -> Cancellable
}
