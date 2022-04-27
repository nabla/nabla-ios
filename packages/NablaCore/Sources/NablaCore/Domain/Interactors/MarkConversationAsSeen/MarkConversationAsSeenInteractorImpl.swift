import Foundation
import NablaUtils

final class MarkConversationAsSeenInteractorImpl: MarkConversationAsSeenInteractor {
    func execute(conversationId: UUID) -> Cancellable {
        conversationItemRepository.markConversationAsSeen(conversationId: conversationId)
    }

    // MARK: - Private

    @Inject private var conversationItemRepository: ConversationItemRepository
}
