import Combine
import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import SnapshotTesting
import XCTest

final class WatchConversationItemsInteractorTests: XCTestCase {
    private var sut: WatchConversationItemsInteractorImpl!
    
    let conversationId = UUID()
    
    private var authenticator: AuthenticatorMock!
    private var itemsRepository: ConversationItemRepositoryMock!
    private var conversationsRepository: ConversationRepositoryMock!
    private var logger: LoggerMock!
    private var gateKeepers: GateKeepersMock!

    override func setUp() {
        super.setUp()
        
        authenticator = .init()
        itemsRepository = .init()
        conversationsRepository = .init()
        logger = .init()
        gateKeepers = .init()
        
        sut = WatchConversationItemsInteractorImpl(
            authenticator: authenticator,
            itemsRepository: itemsRepository,
            conversationsRepository: conversationsRepository,
            gateKeepers: gateKeepers,
            logger: logger
        )
        
        authenticator.given(.isSessionInitialized(willReturn: true))
        conversationsRepository.given(.getConversationTransientId(from: .any, willReturn: .init(remoteId: conversationId)))
    }

    func testFiltersVideoCallRoomInteractiveMessageWhenVideoCallNotSupported() throws {
        // GIVEN
        gateKeepers.given(.supportVideoCallActionRequests(getter: false))
        let receivedValue = expectation(description: "Received conversation items")
        let elements: [ConversationItem] = [
            TextMessageItem(id: .init(), date: .init(), sender: .me, sendingState: .sent, replyTo: .none, content: "Hello"),
            VideoCallRoomInteractiveMessage(id: .init(), date: .init(), sender: .me, status: .closed),
            TextMessageItem(id: .init(), date: .init(), sender: .me, sendingState: .sent, replyTo: .none, content: "World"),
        ]
        let response = AnyResponse<PaginatedList<ConversationItem>, NablaError>(
            data: PaginatedList(elements: elements, loadMore: nil),
            isDataFresh: true,
            refreshingState: .refreshed
        )
        let publisher = Just(response)
            .setFailureType(to: NablaError.self)
            .eraseToAnyPublisher()
        
        itemsRepository.given(.watchConversationItems(ofConversationWithId: .any, willReturn: publisher))
        
        // WHEN
        var result: PaginatedList<ConversationItem>!
        let cancellable = sut.execute(conversationId: conversationId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    XCTFail("Received unexpected error: \(error)")
                }
            }, receiveValue: { conversationItems in
                result = conversationItems.data
                receivedValue.fulfill()
            })
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
        // THEN
        XCTRequireEqual(result.elements.count, 2)
        XCTAssert(result.elements[0] is TextMessageItem)
        XCTAssert(result.elements[1] is TextMessageItem)
    }
}
