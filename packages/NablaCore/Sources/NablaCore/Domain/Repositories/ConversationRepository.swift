import Foundation

protocol ConversationRepository {
    func watch(callback: @escaping (Result<ConversationList, GQLError>) -> Void) -> PaginatedWatcher
}
