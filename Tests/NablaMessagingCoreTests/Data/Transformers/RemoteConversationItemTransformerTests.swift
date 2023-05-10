import NablaCoreTestsUtils
@testable import NablaMessagingCore
import XCTest

class RemoteConversationItemTransformerTests: XCTestCase {
    private var sut: RemoteConversationItemTransformer!
    private var logger: LoggerMock!

    override func setUp() {
        super.setUp()
        
        logger = .init()
        
        sut = .init(logger: logger)
    }

    func testAuthorIsMe() throws {
        // GIVEN
        let message = GQL.MessageFragment(
            id: .init(),
            clientId: nil,
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            author: GQL.MessageFragment.Author.makePatient(id: .init(), isMe: true, displayName: "Me"),
            content: GQL.MessageFragment.Content.makeTextMessageContent(text: "Hello world!"),
            replyTo: nil
        )
        let item = GQL.ConversationItemFragment(unsafeResultMap: message.resultMap)
        
        // WHEN
        let result = sut.transform(item)
        // THEN
        let text = XCTRequire(result, toBe: TextMessageItem.self)
        XCTAssertEqual(text.sender, .me)
    }
    
    func testAuthorIsOtherPatient() throws {
        // GIVEN
        let patientId = UUID()
        let message = GQL.MessageFragment(
            id: .init(),
            clientId: nil,
            createdAt: Date(timeIntervalSinceReferenceDate: 0),
            author: GQL.MessageFragment.Author.makePatient(id: patientId, isMe: false, displayName: "Someone else"),
            content: GQL.MessageFragment.Content.makeTextMessageContent(text: "Hello world!"),
            replyTo: nil
        )
        let item = GQL.ConversationItemFragment(unsafeResultMap: message.resultMap)
        
        // WHEN
        let result = sut.transform(item)
        // THEN
        let text = XCTRequire(result, toBe: TextMessageItem.self)
        XCTAssertEqual(text.sender, .patient(.init(id: patientId, displayName: "Someone else")))
    }
}
