import Foundation
import NablaUtils

class WatchConversationsInteractorImpl: WatchConversationsInteractor {
    // MARK: - WatchConversationsInteractor
    
    func execute(handler: ResultHandler<ConversationList, NablaWatchConversationsError>) -> PaginatedWatcher {
        conversationRepository.watchConversations(handler: handler)
    }
    
    // MARK: - private
    
    @Inject private var conversationRepository: ConversationRepository
}
