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
        let env = await TestEnvironment.make()
        
        // swiftlint:disable force_unwrapping
        env.mockUUIDGenerator.values = [
            UUID(uuidString: "157C934B-6199-4B2B-9A83-5B06E76C04BE")!,
        ]
        env.session.beginRecording()
        _ = try await env.messagingClient.createConversation(withMessage: .text(content: "Hello"), title: nil, providerIds: nil)
        
        let endRecordingCompletion = expectation(description: "endRecording did complete")
        env.session.endRecording {
            endRecordingCompletion.fulfill()
        }
        wait(for: [endRecordingCompletion], timeout: 3)
    }

    func testCreateConversationThenConversationIsReturned() async throws {
        let env = await TestEnvironment.make()
        // swiftlint:disable force_unwrapping
        env.mockUUIDGenerator.values = [
            UUID(uuidString: "78069512-1617-42EB-9E4A-C1114B1DA90D")!,
        ]
        env.session.beginRecording()
        
        // 1 - Watch conversations
        var initalConversationsCount = -1
        let initialListDidLoad = expectation(description: "Initial conversation list did load")
        let watcher1 = env.messagingClient.watchConversations()
            .nabla.sink(
                receiveValue: { response in
                    initalConversationsCount = response.data.elements.count
                    initialListDidLoad.fulfill()
                },
                receiveError: { error in
                    XCTFail("Received error: \(error)")
                }
            )
        wait(for: [initialListDidLoad], timeout: 3)
        watcher1.cancel()
        
        // 2 - Create conversation
        let createdConversation = try await env.messagingClient.createConversation(withMessage: .text(content: "Hello"))
        
        // 3 - Observe conversations again
        let finalListDidLoad = expectation(description: "Final conversation list did load")
        let watcher2 = env.messagingClient.watchConversations()
            .nabla.sink(
                receiveValue: { response in
                    XCTAssertEqual(response.data.elements.count, initalConversationsCount + 1)
                    // TODO: Fix conversations order https://github.com/nabla/health/issues/20428
                    XCTAssertTrue(response.data.elements.contains(where: { $0.id == createdConversation.id }))
//                    XCTAssertEqual(conversations.elements.first?.id, createdConversation.id)
                    finalListDidLoad.fulfill()
                },
                receiveError: { error in
                    XCTFail("Received error: \(error)")
                }
            )
        wait(for: [finalListDidLoad], timeout: 3)
        watcher2.cancel()
        
        let endRecordingCompletion = expectation(description: "endRecording did complete")
        env.session.endRecording {
            endRecordingCompletion.fulfill()
        }
        wait(for: [endRecordingCompletion], timeout: 3)
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
