import Foundation

protocol ConversationRemoteDataSource {
    func createConversation(completion: @escaping (Result<RemoteConversation, GQLError>) -> Void) -> Cancellable
    func watchConversations(callback: @escaping (Result<RemoteConversationList, GQLError>) -> Void) -> PaginatedWatcher
}
