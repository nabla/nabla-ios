import Foundation
import NablaUtils

class ConversationItemRepositoryImpl: ConversationItemRepository {
    func observeConversationItems(
        ofConversationWithId conversationId: UUID,
        callback: @escaping (Result<ConversationItems, Error>) -> Void
    ) -> Cancellable {
        let merger = ConversationItemsMerger(conversationId: conversationId, callback: callback)
        merger.resume()
        return merger
    }
    
    // MARK: - Private
    
    @Inject private var remoteDataSource: ConversationItemRemoteDataSource
    @Inject private var localDataSource: ConversationItemLocalDataSource
}
