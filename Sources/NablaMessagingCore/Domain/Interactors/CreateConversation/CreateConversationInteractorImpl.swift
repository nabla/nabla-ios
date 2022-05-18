import Foundation
import NablaUtils

final class CreateConversationInteractorImpl: CreateConversationInteractor {
    // MARK: - Initializer

    init(conversationRepository: ConversationRepository) {
        repository = conversationRepository
    }

    // MARK: - Internal
    
    func execute(handler: ResultHandler<Conversation, NablaCreateConversationError>) -> Cancellable {
        repository.createConversation(handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationRepository
}
