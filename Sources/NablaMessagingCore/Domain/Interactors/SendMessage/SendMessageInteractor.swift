import Foundation

protocol SendMessageInteractor {
    func execute(
        message: MessageInput,
        replyToMessageId: UUID?,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
