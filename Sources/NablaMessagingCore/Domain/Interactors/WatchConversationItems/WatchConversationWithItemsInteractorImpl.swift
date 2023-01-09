import Combine
import Foundation
import NablaCore

class WatchConversationItemsInteractorImpl: AuthenticatedInteractor, WatchConversationItemsInteractor {
    // MARK: - Initializer

    init(
        authenticator: Authenticator,
        itemsRepository: ConversationItemRepository,
        conversationsRepository: ConversationRepository,
        gateKeepers: GateKeepers,
        logger: Logger
    ) {
        self.itemsRepository = itemsRepository
        self.conversationsRepository = conversationsRepository
        self.gateKeepers = gateKeepers
        self.logger = logger
        super.init(authenticator: authenticator)
    }

    // MARK: - Internal
    
    func execute(conversationId: UUID) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError> {
        guard isAuthenticated else {
            return Fail(error: MissingAuthenticationProviderError()).eraseToAnyPublisher()
        }
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return itemsRepository
            .watchConversationItems(ofConversationWithId: transientId)
            .map { [logger, gateKeepers] (conversationItems: PaginatedList<ConversationItem>) -> PaginatedList<ConversationItem> in
                if gateKeepers.supportVideoCallActionRequests { return conversationItems }
                var elements = conversationItems.elements
                elements.removeAll { $0 is VideoCallRoomInteractiveMessage }
                if conversationItems.elements.count != elements.count {
                    logger.warning(message: "Found some `VideoCallRoomInteractiveMessage` but the `NablaVideoCallModule` is not registered.")
                }
                return PaginatedList(elements: elements, loadMore: conversationItems.loadMore)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
    private let gateKeepers: GateKeepers
    private let logger: Logger
}
