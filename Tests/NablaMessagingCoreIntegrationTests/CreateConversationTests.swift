import Apollo
import Combine
import DVR
@testable import NablaMessagingCore
import XCTest

class CreateConversationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        clearUserDefaults()
    }
    
    func testCreateConversation() async throws {
        let env = TestEnvironment.make()
        
        env.session.beginRecording()
        _ = try await env.messagingClient.createConversation(title: nil, providerIds: nil)
        env.session.endRecording()
    }

    func testCreateConversationThenConversationIsReturned() async throws {
        let env = TestEnvironment.make()
        env.session.beginRecording()

        // 1 - Watch conversations
        var initalConversationsCount = -1
        let initialListDidLoad = expectation(description: "Initial conversation list did load")
        let watcher1 = env.messagingClient.watchConversations()
            .nabla.sink(
                receiveValue: { conversations in
                    initalConversationsCount = conversations.elements.count
                    initialListDidLoad.fulfill()
                },
                receiveError: { error in
                    XCTFail("Received error: \(error)")
                }
            )
        wait(for: [initialListDidLoad], timeout: 3)
        watcher1.cancel()
        
        // 2 - Create conversation
        let createdConversation = try await env.messagingClient.createConversation()
        
        // 3 - Observe conversations again
        let finalListDidLoad = expectation(description: "Final conversation list did load")
        let watcher2 = env.messagingClient.watchConversations()
            .nabla.sink(
                receiveValue: { conversations in
                    XCTAssertEqual(conversations.elements.count, initalConversationsCount + 1)
                    // TODO: Fix conversations order https://github.com/nabla/health/issues/20428
                    XCTAssertTrue(conversations.elements.contains(where: { $0.id == createdConversation.id }))
//                    XCTAssertEqual(conversations.elements.first?.id, createdConversation.id)
                    finalListDidLoad.fulfill()
                },
                receiveError: { error in
                    XCTFail("Received error: \(error)")
                }
            )
        wait(for: [finalListDidLoad], timeout: 3)
        watcher2.cancel()
        
        env.session.endRecording()
    }
}

extension XCTestCase {
    func clearUserDefaults() {
        UserDefaults.resetStandardUserDefaults()
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
}
