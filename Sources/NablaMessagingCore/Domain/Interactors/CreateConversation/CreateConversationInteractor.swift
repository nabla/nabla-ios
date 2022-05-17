import Foundation

protocol CreateConversationInteractor {
    func execute(handler: ResultHandler<Conversation, NablaCreateConversationError>) -> Cancellable
}
