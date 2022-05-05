import Foundation

protocol ConversationRepository {
    func watchConversation(_ conversationId: UUID, callback: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
    func watchConversations(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
}
