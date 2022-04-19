import Foundation

protocol ConversationRemoteDataSource {
    func createConversation(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
}
