import Foundation
import NablaUtils

class WatchConversationInteractorImpl: WatchConversationInteractor {
    // MARK: - WatchConversationInteractor
    
    func execute(_ conversationId: UUID, callback: @escaping (Result<Conversation, Error>) -> Void) -> Cancellable {
        conversationRepository.watchConversation(conversationId, callback: callback)
    }
    
    // MARK: - private
    
    @Inject private var conversationRepository: ConversationRepository
}
