import Foundation

protocol SendMessageInteractor {
    func execute(
        message: MessageInput,
        conversationId: UUID,
        callback: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
}
