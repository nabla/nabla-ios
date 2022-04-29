import Foundation

protocol SendMessageInteractor {
    func execute(
        message: MessageInput,
        conversationId: UUID,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancellable
}
