import Foundation

public protocol WatchConversationListInteractor {
    func execute(callback: @escaping (Result<ConversationList, GQLError>) -> Void) -> PaginatedWatcher
}
