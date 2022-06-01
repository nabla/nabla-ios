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
        let item = LocalTextMessageItem.mock()
        // WHEN
        sut.addConversationItem(item, toConversationWithId: conversationId)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 1)
        XCTAssertEqual(items[0].clientId, item.clientId)
    }
    
    func testStoresMessageItemsToTheCorrectConversation() {
        // GIVEN
        let item = LocalTextMessageItem.mock()
        let otherConversationId = UUID()
        // WHEN
        sut.addConversationItem(item, toConversationWithId: otherConversationId)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 0)
    }
    
    func testStoresMessageItemsInDateOrder() {
        // GIVEN
        let item1 = LocalTextMessageItem.mock(dateOffset: 0)
        let item2 = LocalTextMessageItem.mock(dateOffset: 1)
        // WHEN
        sut.addConversationItem(item2, toConversationWithId: conversationId)
        sut.addConversationItem(item1, toConversationWithId: conversationId)
        let items = sut.getConversationItems(ofConversationWithId: conversationId)
        // THEN
        XCTRequireEqual(items.count, 2)
        XCTAssertEqual(items[0].clientId, item1.clientId)
        XCTAssertEqual(items[1].clientId, item2.clientId)
    }
    
    // MARK: updateConversationItem(_:inConversationWithId:)
    
    func testUpdatesMessageItems() {
        // GIVEN
        var item = LocalTextMessageItem.mock(sendingState: .toBeSent)
        sut.addConversationItem(item, toConversationWithId: conversationId)
        // WHEN
        item.sendingState = .failed
        sut.updateConversationItem(item, inConversationWithId: conversationId)
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
        let item = LocalTextMessageItem.mock()
        sut.addConversationItem(item, toConversationWithId: conversationId)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId) { items in
            XCTAssertEqual(items.count, 1)
            watcherWasCalledWithInitialValue.fulfill()
        }
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testNotifiesChangesWhenAddingMessageItem() {
        // GIVEN
        let item = LocalTextMessageItem.mock()
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        let watcherWasCalledWithNewValue = expectation(description: "watcher was called with new value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId) { items in
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
        sut.addConversationItem(item, toConversationWithId: conversationId)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue, watcherWasCalledWithNewValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testNotifiesChangesWhenUpdatingMessageItem() {
        // GIVEN
        var item = LocalTextMessageItem.mock(sendingState: .toBeSent)
        sut.addConversationItem(item, toConversationWithId: conversationId)
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        let watcherWasCalledWithUpdatedValue = expectation(description: "watcher was called with updated value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId) { items in
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
        sut.updateConversationItem(item, inConversationWithId: conversationId)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue, watcherWasCalledWithUpdatedValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testDoesNotNotifyChangesFromOtherConversations() {
        // GIVEN
        let item = LocalTextMessageItem.mock()
        let otherConversationId = UUID()
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId) { items in
            switch items.count {
            case 0:
                watcherWasCalledWithInitialValue.fulfill()
            default:
                XCTFail("Unexpect watcher callback call")
            }
        }
        sut.addConversationItem(item, toConversationWithId: otherConversationId)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNotNil(watcher) // `watcher` must be retained past the `wait` for tests to work
    }
    
    func testStopsNotifyingChangesWhenCancelled() {
        // GIVEN
        let item = LocalTextMessageItem.mock()
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        let watcher = sut.watchConversationItems(ofConversationWithId: conversationId) { items in
            switch items.count {
            case 0:
                watcherWasCalledWithInitialValue.fulfill()
            default:
                XCTFail("Unexpect watcher callback call")
            }
        }
        watcher.cancel()
        sut.addConversationItem(item, toConversationWithId: conversationId)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNotNil(watcher)
    }
    
    func testStopsNotifyingChangesWhenDeallocated() {
        // GIVEN
        let item = LocalTextMessageItem.mock()
        let watcherWasCalledWithInitialValue = expectation(description: "watcher was called with initial value")
        // WHEN
        var watcher: Cancellable? = sut.watchConversationItems(ofConversationWithId: conversationId) { items in
            switch items.count {
            case 0:
                watcherWasCalledWithInitialValue.fulfill()
            default:
                XCTFail("Unexpect watcher callback call")
            }
        }
        watcher = nil
        sut.addConversationItem(item, toConversationWithId: conversationId)
        // THEN
        wait(for: [watcherWasCalledWithInitialValue], timeout: 0)
        XCTAssertNil(watcher) // Silences "variable 'watcher' was written to, but never read" warning
    }
}
