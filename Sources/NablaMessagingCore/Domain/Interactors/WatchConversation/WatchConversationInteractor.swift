import Foundation

public protocol WatchConversationInteractor {
    func execute(_ conversationId: UUID, callback: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
}
