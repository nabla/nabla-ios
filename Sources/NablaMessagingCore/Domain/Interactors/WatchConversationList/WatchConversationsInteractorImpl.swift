import Foundation
import NablaUtils

class WatchConversationsInteractorImpl: WatchConversationsInteractor {
    // MARK: - Initializer

    init(conversationRepository: ConversationRepository) {
        repository = conversationRepository
    }

    // MARK: - WatchConversationsInteractor
    
    func execute(handler: ResultHandler<ConversationList, NablaWatchConversationsError>) -> PaginatedWatcher {
        repository.watchConversations(handler: handler)
    }
    
    // MARK: - private
    
    private let repository: ConversationRepository
}
