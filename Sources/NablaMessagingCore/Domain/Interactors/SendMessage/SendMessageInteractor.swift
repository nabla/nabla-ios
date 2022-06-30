import Foundation
import NablaCore

protocol SendMessageInteractor {
    func execute(
        message: MessageInput,
        replyToMessageId: UUID?,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
