@testable import NablaMessagingCore
@testable import NablaMessagingCoreTestsUtils
import XCTest

class ConversationLocalDataSourceTests: XCTestCase {
    func testWatchSendsNilWhenConversationNotFound() {
        // GIVEN
        let sut = ConversationLocalDataSourceImpl()
        // WHEN
        let nilExpectation = expectation(description: "Conversation is nil")
        let watcher = sut.watchConversation(UUID())
            .sink { conversation in
                XCTAssertNil(conversation)
                nilExpectation.fulfill()
            }
        // THEN
        waitForExpectations(timeout: 0.5)
        XCTAssertNotNil(watcher)
    }
    
    func testWatchIsTriggeredOnUpdate() throws {
        // GIVEN
        let sut = ConversationLocalDataSourceImpl()
        var conversation = sut.startConversation(title: "Some title", providerIds: nil)
        
        let initialExpectation = expectation(description: "Watcher should emit once with the initial `title`")
        let updatedExpectation = expectation(description: "Watcher should emit again with the new `title`")
        let watcher = sut.watchConversation(conversation.id)
            .sink { conversation in
                switch conversation?.title {
                case "Some title":
                    initialExpectation.fulfill()
                case "Some other title":
                    updatedExpectation.fulfill()
                default:
                    XCTFail("Unexpected conversation title")
                }
            }
        
        // WHEN
        conversation.title = "Some other title"
        sut.updateConversation(conversation)
        // THEN
        waitForExpectations(timeout: 0.5)
        XCTAssertNotNil(watcher)
    }
}
