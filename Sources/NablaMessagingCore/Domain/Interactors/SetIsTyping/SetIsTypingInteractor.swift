import Foundation
import NablaCore

protocol SetIsTypingInteractor {
    func execute(
        isTyping: Bool,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
