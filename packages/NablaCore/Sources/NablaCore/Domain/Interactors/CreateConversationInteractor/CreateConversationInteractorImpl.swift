import Foundation
import NablaUtils

final class CreateConversationInteractorImpl: CreateConversationInteractor {
    // MARK: - Internal
    
    func execute(completion: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        repository.createConversation(completion: completion)
    }
    
    // MARK: - Private
    
    @Inject private var repository: ConversationRepository
}
