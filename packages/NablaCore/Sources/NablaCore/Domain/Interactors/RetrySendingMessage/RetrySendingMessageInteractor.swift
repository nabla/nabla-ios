import Foundation

protocol RetrySendingMessageInteractor {
    func execute(
        itemId: UUID,
        conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
}
