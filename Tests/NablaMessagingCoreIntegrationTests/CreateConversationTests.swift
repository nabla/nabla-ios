import Apollo
import DVR
@testable import NablaMessagingCore
import XCTest

class CreateConversationTests: XCTestCase {
    func testCreateConversation() throws {
        let env = TestEnvironment.make()
        
        let expectation = expectation(description: "Create conversation did complete")
        var createConversationAction: Any?
        
        env.session.beginRecording()
        
        createConversationAction = env.messagingClient.createConversation(
            title: nil,
            providerIds: nil
        ) { result in
            switch result {
            case let .failure(error):
                XCTFail("Received error: \(error)")
            case .success:
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(createConversationAction)
        env.session.endRecording()
    }

    func testCreateConversationThenConversationIsReturned() throws {
        let env = TestEnvironment.make()
        env.session.beginRecording()

        // 1 - Watch conversations
        var initalConversationsCount = -1
        let initialListDidLoad = expectation(description: "Initial conversation list did load")
        let watcher1 = env.messagingClient.watchConversations { result in
            switch result {
            case let .failure(error):
                XCTFail("Received error: \(error)")
            case let .success(list):
                initalConversationsCount = list.conversations.count
                initialListDidLoad.fulfill()
            }
        }
        wait(for: [initialListDidLoad], timeout: 3)
        watcher1.cancel()
        
        // 2 - Create conversation
        var createdConversation: Conversation?
        let createConversationDidComplete = expectation(description: "Create conversation did complete")
        let createConversationAction = env.messagingClient.createConversation(
            title: nil,
            providerIds: nil
        ) { result in
            switch result {
            case let .failure(error):
                XCTFail("Received error: \(error)")
            case let .success(conversation):
                createdConversation = conversation
                createConversationDidComplete.fulfill()
            }
        }
        wait(for: [createConversationDidComplete], timeout: 3)
        createConversationAction.cancel()
        
        // 3 - Observe conversations again
        let finalListDidLoad = expectation(description: "Final conversation list did load")
        let watcher2 = env.messagingClient.watchConversations { result in
            switch result {
            case let .failure(error):
                XCTFail("Received error: \(error)")
            case let .success(list):
                XCTAssertEqual(list.conversations.count, initalConversationsCount + 1)
                // TODO: Fix conversations order https://github.com/nabla/health/issues/20428
                XCTAssertTrue(list.conversations.contains(where: { $0.id == createdConversation?.id }))
//                XCTAssertEqual(list.conversations.first?.id, createdConversation?.id)
                finalListDidLoad.fulfill()
            }
        }
        wait(for: [finalListDidLoad], timeout: 3)
        watcher2.cancel()
        
        env.session.endRecording()
    }
}
