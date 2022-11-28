import Foundation
import NablaCore

final class RetrySendingMessageInteractorImpl: AuthenticatedInteractor, RetrySendingMessageInteractor {
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

    // MARK: - RetrySendingMessageInteractor

    func execute(
        itemId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> NablaCancellable {
        guard isAuthenticated else {
            return Failure(handler: handler, error: MissingAuthenticationProviderError())
        }
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return itemsRepository.retrySending(itemWithId: itemId, inConversationWithId: transientId, handler: handler)
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
}
