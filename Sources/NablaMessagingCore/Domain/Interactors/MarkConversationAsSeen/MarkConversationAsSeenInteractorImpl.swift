import Foundation
import NablaUtils

final class MarkConversationAsSeenInteractorImpl: MarkConversationAsSeenInteractor {
    func execute(
        conversationId: UUID,
        handler: ResultHandler<Void, NablaMarkConversationAsSeenError>
    ) -> Cancellable {
        conversationItemRepository.markConversationAsSeen(conversationId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    @Inject private var conversationItemRepository: ConversationItemRepository
}
