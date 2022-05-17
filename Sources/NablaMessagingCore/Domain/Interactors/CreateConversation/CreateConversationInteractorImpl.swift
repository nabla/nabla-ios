import Foundation
import NablaUtils

final class CreateConversationInteractorImpl: CreateConversationInteractor {
    // MARK: - Internal
    
    func execute(handler: ResultHandler<Conversation, NablaCreateConversationError>) -> Cancellable {
        repository.createConversation(handler: handler)
    }
    
    // MARK: - Private
    
    @Inject private var repository: ConversationRepository
}
