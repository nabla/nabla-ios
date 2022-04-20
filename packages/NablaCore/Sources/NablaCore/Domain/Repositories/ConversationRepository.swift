import Foundation

protocol ConversationRepository {
    func watch(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
}
