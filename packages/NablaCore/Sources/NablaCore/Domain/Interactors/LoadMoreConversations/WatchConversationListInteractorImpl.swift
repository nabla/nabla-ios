import Foundation
import NablaUtils

class WatchConversationListInteractorImpl: WatchConversationListInteractor {
    // MARK: - WatchConversationListInteractor

    func execute(callback: @escaping (Result<ConversationList, Error>) -> Void) -> PaginatedWatcher {
        conversationRepository.watch(callback: callback)
    }

    // MARK: - private

    @Inject private var conversationRepository: ConversationRepository
}
