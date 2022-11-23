@testable import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import SwiftyMocky
import XCTest

class ConversationItemRepositoryImplTests: XCTestCase {
    private var itemsRemoteDataSource: ConversationItemRemoteDataSourceMock!
    private var itemsLocalDataSource: ConversationItemLocalDataSourceMock!
    private var fileUploadRemoteDataSource: FileUploadRemoteDataSourceMock!
    private var conversationLocalDataSource: ConversationLocalDataSourceMock!
    private var conversationRemoteDataSource: ConversationRemoteDataSourceMock!
    private var logger: LoggerMock!
    
    private var sut: ConversationItemRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        
        itemsRemoteDataSource = .init()
        itemsLocalDataSource = .init()
        fileUploadRemoteDataSource = .init()
        conversationLocalDataSource = .init()
        conversationRemoteDataSource = .init()
        logger = .init()
        
        sut = ConversationItemRepositoryImpl(
            itemsRemoteDataSource: itemsRemoteDataSource,
            itemsLocalDataSource: itemsLocalDataSource,
            fileUploadRemoteDataSource: fileUploadRemoteDataSource,
            conversationLocalDataSource: conversationLocalDataSource,
            conversationRemoteDataSource: conversationRemoteDataSource,
            logger: logger
        )
    }

    func testFailedUploadMessagesAreSetToFailedState() throws {
        // GIVEN
        let input = MessageInput.image(
            content: .init(
                fileName: "fileName",
                source: .url(URL(fileURLWithPath: "")),
                size: nil,
                mimeType: .jpg
            )
        )
        let conversationId = TransientUUID(remoteId: .init())
        let expectation = expectation(description: "")
        fileUploadRemoteDataSource.perform(.upload(file: .any, handler: .any, perform: { _, handler in
            handler(.failure(.cannotReadFileData))
        }))
        fileUploadRemoteDataSource.given(.upload(file: .any, handler: .any, willReturn: Failure()))
        Matcher.default.register(LocalConversationItem.self) { rhs, lhs in
            guard let rhs = rhs as? LocalImageMessageItem, let lhs = lhs as? LocalImageMessageItem else { return false }
            return rhs.conversationId == lhs.conversationId
                && rhs.sendingState == lhs.sendingState
                && rhs.content.media.fileName == lhs.content.media.fileName
                && rhs.content.media.content == lhs.content.media.content
        }
        
        // WHEN
        let cancellable = sut.sendMessage(
            input,
            replyToMessageId: nil,
            inConversationWithId: conversationId,
            handler: .init { _ in
                expectation.fulfill()
            }
        )
        
        // THEN
        waitForExpectations(timeout: 0.1)
        itemsLocalDataSource.verify(
            .addConversationItem(
                .value(
                    LocalImageMessageItem(
                        conversationId: conversationId.localId,
                        clientId: .init(),
                        date: Date(),
                        sendingState: .toBeSent,
                        replyToUuid: nil,
                        content: .init(
                            media:
                            .init(
                                fileName: "fileName",
                                source: .url(URL(fileURLWithPath: "")),
                                size: nil,
                                mimeType: .jpg
                            )
                        )
                    )
                )
            ),
            count: 1
        )
        itemsLocalDataSource.verify(
            .updateConversationItem(
                .value(
                    LocalImageMessageItem(
                        conversationId: conversationId.localId,
                        clientId: .init(),
                        date: Date(),
                        sendingState: .failed,
                        replyToUuid: nil,
                        content: .init(
                            media:
                            .init(
                                fileName: "fileName",
                                source: .url(URL(fileURLWithPath: "")),
                                size: nil,
                                mimeType: .jpg
                            )
                        )
                    )
                )
            ),
            count: 1
        )
        XCTAssertNotNil(cancellable)
    }
}
