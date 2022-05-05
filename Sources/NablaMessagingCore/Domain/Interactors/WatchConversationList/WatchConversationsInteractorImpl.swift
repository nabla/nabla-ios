import Foundation
import NablaUtils

class WatchConversationsInteractorImpl: WatchConversationsInteractor {
    // MARK: - WatchConversationsInteractor
    
    func execute(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        conversationRepository.watch(callback: callback)
    }
    
    // MARK: - private
    
    @Inject private var conversationRepository: ConversationRepository
}
