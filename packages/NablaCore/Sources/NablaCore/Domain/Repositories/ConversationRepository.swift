import Foundation

protocol ConversationRepository {
    func watch(callback: @escaping (Result<ConversationList, GQLError>) -> Void) -> PaginatedWatcher
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
}
