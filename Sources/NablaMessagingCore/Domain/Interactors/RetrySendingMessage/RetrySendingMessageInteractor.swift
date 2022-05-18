import Foundation

protocol RetrySendingMessageInteractor {
    func execute(
        itemId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
