import Foundation

public protocol WatchConversationsInteractor {
    func execute(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher
}
