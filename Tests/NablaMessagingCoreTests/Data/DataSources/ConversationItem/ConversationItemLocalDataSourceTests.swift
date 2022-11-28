import Combine
import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import XCTest

class ConversationItemLocalDataSourceTests: XCTestCase {
    private var conversationId: UUID!
    
    private var sut: ConversationItemLocalDataSourceImpl!

    override func setUp() {
        super.setUp()
        conversationId = UUID()
        sut = ConversationItemLocalDataSourceImpl()
    }
    
    // MARK: getConversationItems(ofConversationWithId:)
    
    func testIsEmptyWhenAllocated() {
        // GIVEN
        // WHEN
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTAssertEqual(items.count, 0)
    }
    
    func testStoresMessageItems() {
        // GIVEN
        let item = LocalTextMessageItem.mock(conversationId: conversationId)
        // WHEN
        sut.addConversationItem(item)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 1)
        XCTAssertEqual(items[0].clientId, item.clientId)
    }
    
    func testStoresMessageItemsToTheCorrectConversation() {
        // GIVEN
        let otherConversationId = UUID()
        let item = LocalTextMessageItem.mock(conversationId: otherConversationId)
        // WHEN
        sut.addConversationItem(item)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 0)
    }
    
    func testStoresMessageItemsInDateOrder() {
        // GIVEN
        let item1 = LocalTextMessageItem.mock(conversationId: conversationId, dateOffset: 0)
        let item2 = LocalTextMessageItem.mock(conversationId: conversationId, dateOffset: 1)
        // WHEN
        sut.addConversationItem(item2)
        sut.addConversationItem(item1)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 2)
        XCTAssertEqual(items[0].clientId, item1.clientId)
        XCTAssertEqual(items[1].clientId, item2.clientId)
    }
    
    // MARK: updateConversationItem(_:inConversationWithId:)
    
    func testUpdatesMessageItems() {
        // GIVEN
        var item = LocalTextMessageItem.mock(conversationId: conversationId, sendingState: .toBeSent)
        sut.addConversationItem(item)
        // WHEN
        item.sendingState = .failed
        sut.updateConversationItem(item)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 1)
        let returnedItem = XCTRequire(items[0], toBe: LocalTextMessageItem.self)
        XCTAssertEqual(returnedItem.clientId, item.clientId)
        XCTAssertEqual(returnedItem.sendingState, .failed)
    }
    
    // MARK: watchConversationItems(ofConversationWithId:)
    
    func testNotifiesCurrentValueOnStart() {
        // GIVEN
        let item = LocalTextMessageItem.mock(conversationId: conversationId)
        sut.addConversationItem(item)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId)
            .sink { items in
                XCTAssertEqual(items.count, 1)
                watcherWasCalledWithInitialValue.fulfill()
            }
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testNotifiesChangesWhenAddingMessageItem() {
        // GIVEN
        let item = LocalTextMessageItem.mock(conversationId: conversationId)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        let watcherWasCalledWithNewValue = expectation(description: "watcher was called with new value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId)
            .sink { items in
                switch items.count {
                case 0:
                    watcherWasCalledWithInitialValue.fulfill()
                case 1:
                    XCTAssertEqual(items[0].clientId, item.clientId)
                    watcherWasCalledWithNewValue.fulfill()
                default:
                    XCTFail("Unexpect watcher callback call")
                }
            }
        sut.addConversationItem(item)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue, watcherWasCalledWithNewValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testNotifiesChangesWhenUpdatingMessageItem() {
        // GIVEN
        var item = LocalTextMessageItem.mock(conversationId: conversationId, sendingState: .toBeSent)
        sut.addConversationItem(item)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        let watcherWasCalledWithUpdatedValue = expectation(description: "watcher was called with updated value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId)
            .sink { items in
                guard let textMessage = items.first as? LocalTextMessageItem else { return XCTFail() }
                switch textMessage.sendingState {
                case .toBeSent:
                    watcherWasCalledWithInitialValue.fulfill()
                case .sent:
                    watcherWasCalledWithUpdatedValue.fulfill()
                default:
                    XCTFail("Unexpect watcher callback call")
                }
            }
        item.sendingState = .sent
        sut.updateConversationItem(item)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue, watcherWasCalledWithUpdatedValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testDoesNotNotifyChangesFromOtherConversations() {
        // GIVEN
        let otherConversationId = UUID()
        let item = LocalTextMessageItem.mock(conversationId: otherConversationId)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId)
            .sink { items in
                switch items.count {
                case 0:
                    watcherWasCalledWithInitialValue.fulfill()
                default:
                    XCTFail("Unexpect watcher callback call")
                }
            }
        sut.addConversationItem(item)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testStopsNotifyingChangesWhenCancelled() {
        // GIVEN
        let item = LocalTextMessageItem.mock(conversationId: conversationId)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId)
            .sink { items in
                switch items.count {
                case 0:
                    watcherWasCalledWithInitialValue.fulfill()
                default:
                    XCTFail("Unexpect watcher callback call")
                }
            }
        watcher.cancel()
        sut.addConversationItem(item)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNotNil(watcher)
    }
    
    func testStopsNotifyingChangesWhenDeallocated() {
        // GIVEN
        let item = LocalTextMessageItem.mock(conversationId: conversationId)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        var watcher: AnyCancellable? = sut.watchConversationItems(ofConversationWithId: conversationId)
            .sink { items in
                switch items.count {
                case 0:
                    watcherWasCalledWithInitialValue.fulfill()
                default:
                    XCTFail("Unexpect watcher callback call")
                }
            }
        watcher = nil
        sut.addConversationItem(item)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNil(watcher) // Silences "variable 'watcher' was written to, but never read" warning
    }
}
