import Foundation

protocol DeleteMessageInteractor {
    func execute(
        messageId: UUID,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
}
