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
    
    func execute(conversationId: UUID) -> AnyPublisher<Response<PaginatedList<ConversationItem>>, NablaError> {
        let transientId = conversationsRepository.getConversationTransientId(from: conversationId)
        return isAuthenticated
            .map { [itemsRepository] in
                itemsRepository.watchConversationItems(ofConversationWithId: transientId)
            }
            .switchToLatest()
            .map { [logger, gateKeepers] response -> AnyResponse<PaginatedList<ConversationItem>, NablaError> in
                if gateKeepers.supportVideoCallActionRequests { return response }
                return response.mapData { conversationItems in
                    Self.filterVideoCallItems(from: conversationItems, logger: logger)
                }
            }
            .map { $0.asResponse() }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private let itemsRepository: ConversationItemRepository
    private let conversationsRepository: ConversationRepository
    private let gateKeepers: GateKeepers
    private let logger: Logger
    
    private static func filterVideoCallItems(from list: PaginatedList<ConversationItem>, logger: Logger) -> PaginatedList<ConversationItem> {
        var elements = list.elements
        elements.removeAll { $0 is VideoCallRoomInteractiveMessage }
        if list.elements.count != elements.count {
            logger.warning(message: "Found some `VideoCallRoomInteractiveMessage` but the `NablaVideoCallModule` is not registered.")
        }
        return PaginatedList(elements: elements, loadMore: list.loadMore)
    }
}
