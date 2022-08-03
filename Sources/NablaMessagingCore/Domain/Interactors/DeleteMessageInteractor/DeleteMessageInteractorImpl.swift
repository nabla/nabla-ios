import Foundation
import NablaCore

final class DeleteMessageInteractorImpl: AuthenticatedInteractor, DeleteMessageInteractor {
    // MARK: - Initializer

    init(
        authenticator: Authenticator,
        itemsRepository: ConversationItemRepository,
        conversationsRepository: ConversationRepository
    ) {
        self.itemsRepository = itemsRepository
        self.conversationsRepository = conversationsRepository
        super.init(authenticator: authenticator)
    }

    // MARK: - DeleteMessageInteractor

    func execute(
        messageId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable {
        guard isAuthenticated(handler: handler) else {
            return Failure()
        }
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return itemsRepository.deleteMessage(
            withId: messageId,
            conversationId: transientId,
            handler: handler
        )
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
}
