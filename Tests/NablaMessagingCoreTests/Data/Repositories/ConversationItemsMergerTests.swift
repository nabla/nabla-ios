import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import XCTest

class ConversationItemsMergerTests: XCTestCase {
    private let conversationId = UUID()
    
    private let remoteDataSource = ConversationItemRemoteDataSourceMock()
    private let localDataSource = ConversationItemLocalDataSourceMock()
    
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
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
            conversationId: conversationId,
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
