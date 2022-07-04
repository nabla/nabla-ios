import NablaCore
import NablaMessagingCore
import XCTest

class AuthenticatedEndpointsTests: XCTestCase {
    private var nablaClient: NablaClient!
    private var messagingClient: NablaMessagingClient!
    
    override func setUp() {
        super.setUp()
        nablaClient = NablaClient(apiKey: "", name: "")
        messagingClient = NablaMessagingClient(client: nablaClient)
    }
    
    private func assertAuthenticationErrorHandler<T>(
        file: StaticString = #filePath, line: UInt = #line
    ) -> (Result<T, NablaError>) -> Void {
        let handlerCalled = expectation(description: "Handler was called")
        return { result in
            switch result {
            case let .failure(error):
                switch error {
                case is MissingAuthenticationProviderError:
                    break
                default:
                    XCTFail("Expected `MissingAuthenticationProviderError`, received \(error)", file: file, line: line)
                }
            case .success:
                XCTFail("Should not succeed", file: file, line: line)
            }
            handlerCalled.fulfill()
        }
    }
    
    func testWatchConversationsFailsWhenNotAuthenticated() {
        _ = messagingClient.watchConversations(handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
    
    func testCreateConversationFailsWhenNotAuthenticated() {
        _ = messagingClient.createConversation(
            title: nil,
            providerIds: nil,
            handler: assertAuthenticationErrorHandler()
        )
        waitForExpectations(timeout: 0.5)
    }
    
    func testWatchConversationFailsWhenNotAuthenticated() {
        _ = messagingClient.watchConversation(.init(), handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
    
    func testWatchItemsOfConversationWithIdFailsWhenNotAuthenticated() {
        _ = messagingClient.watchItems(ofConversationWithId: .init(), handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
    
    func testMarkConversationAsSeenFailsWhenNotAuthenticated() {
        _ = messagingClient.markConversationAsSeen(.init(), handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
    
    func testSetIsTypingFailsWhenNotAuthenticated() {
        _ = messagingClient.setIsTyping(true, inConversationWithId: .init(), handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
    
    func testSendMessageInConversationWithIdFailsWhenNotAuthenticated() {
        _ = messagingClient.sendMessage(
            .text(content: "Hello world!"),
            replyingToMessageWithId: nil,
            inConversationWithId: .init(),
            handler: assertAuthenticationErrorHandler()
        )
        waitForExpectations(timeout: 0.5)
    }
    
    func testRetrySendingItemWithIdInConversationWithIdFailsWhenNotAuthenticated() {
        _ = messagingClient.retrySending(itemWithId: .init(), inConversationWithId: .init(), handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
    
    func testDeleteMessageWithIdInConversationWithIdFailsWhenNotAuthenticated() {
        _ = messagingClient.deleteMessage(withId: .init(), conversationId: .init(), handler: assertAuthenticationErrorHandler())
        waitForExpectations(timeout: 0.5)
    }
}
