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
        let author = GQL.MessageAuthorFragment(
            data: .init(
                [
                    "__typename": "Patient",
                    "displayName": "Me",
                    "id": GQL.UUID(),
                    "isMe": true,
                ],
                variables: nil
            )
        )
        let item = GQL.ConversationItemFragment(
            data: DataDict(
                [
                    "__typename": "Message",
                    "id": GQL.UUID(),
                    "author": author.__data._data,
                    "content": [
                        "__typename": "TextMessageContent",
                        "text": "Hello world!",
                    ],
                    "createdAt": GQL.DateTime(timeIntervalSinceReferenceDate: 0),
                ],
                variables: nil
            )
        )
        
        // WHEN
        let result = sut.transform(item)
        // THEN
        let text = XCTRequire(result, toBe: TextMessageItem.self)
        XCTAssertEqual(text.sender, .me)
        XCTAssertEqual(text.content, "Hello world!")
    }
    
    func testAuthorIsOtherPatient() throws {
        // GIVEN
        let patientId = UUID()
        let author = GQL.MessageAuthorFragment(
            data: .init(
                [
                    "__typename": "Patient",
                    "displayName": "Someone else",
                    "id": patientId,
                    "isMe": false,
                ],
                variables: nil
            )
        )
        let item = GQL.ConversationItemFragment(
            data: DataDict(
                [
                    "__typename": "Message",
                    "id": GQL.UUID(),
                    "author": author.__data._data,
                    "content": [
                        "__typename": "TextMessageContent",
                        "text": "Hello world!",
                    ],
                    "createdAt": GQL.DateTime(timeIntervalSinceReferenceDate: 0),
                ],
                variables: nil
            )
        )
        // WHEN
        let result = sut.transform(item)
        // THEN
        let text = XCTRequire(result, toBe: TextMessageItem.self)
        XCTAssertEqual(text.sender, .patient(.init(id: patientId, displayName: "Someone else")))
    }
}
