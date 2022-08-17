import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import XCTest

class ConversationItemsMergerTests: XCTestCase {
    private let conversationId = TransientUUID(remoteId: .init())
    
    private let remoteDataSource = ConversationItemRemoteDataSourceMock()
    private let localDataSource = ConversationItemLocalDataSourceMock()
    private let logger = LoggerMock()
    
    private let remoteWatcher = PaginatedWatcherMock()
    private let localCancellable = CancellableMock()
    
    override func setUp() {
        super.setUp()
        
        remoteDataSource.given(.watchConversationItems(ofConversationWithId: .any, handler: .any, willReturn: remoteWatcher))
        localDataSource.given(.watchConversationItems(ofConversationWithId: .any, callback: .any, willReturn: localCancellable))
    }

    func testWatchersAreCancelledOnDeinit() throws {
        // GIVEN
        var sut: ConversationItemsMerger? = .init(
            conversationId: conversationId,
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
            logger: logger,
            handler: .void
        )
        sut?.resume()
        // WHEN
        sut = nil
        // THEN
        remoteWatcher.verify(.cancel())
        localCancellable.verify(.cancel())
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
}
