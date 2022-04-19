import Foundation

protocol CreateConversationInteractor {
    func execute(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable
}
