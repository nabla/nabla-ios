import Foundation

protocol SendMessageInteractor {
    func execute(
        message: MessageInput,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaSendMessageError>
    ) -> Cancellable
}
