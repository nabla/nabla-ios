import Foundation
import NablaUtils

final class MarkConversationAsSeenInteractorImpl: MarkConversationAsSeenInteractor {
    // MARK: - Initializer

    init(conversationItemRepository: ConversationItemRepository) {
        repository = conversationItemRepository
    }

    // MARK: - MarkConversationAsSeenInteractor

    func execute(
        conversationId: UUID,
        handler: ResultHandler<Void, NablaMarkConversationAsSeenError>
    ) -> Cancellable {
        repository.markConversationAsSeen(conversationId: conversationId, handler: handler)
    }
    
    // MARK: - Private
    
    private let repository: ConversationItemRepository
}
