import Foundation
import NablaUtils

class WatchConversationInteractorImpl: WatchConversationInteractor {
    // MARK: - WatchConversationInteractor
    
    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaWatchConversationError>) -> Cancellable {
        conversationRepository.watchConversation(conversationId, handler: handler)
    }
    
    // MARK: - private
    
    @Inject private var conversationRepository: ConversationRepository
}
