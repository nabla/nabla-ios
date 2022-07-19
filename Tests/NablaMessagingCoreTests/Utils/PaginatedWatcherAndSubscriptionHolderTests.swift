import NablaCoreTestsUtils
@testable import NablaMessagingCore
import XCTest

class PaginatedWatcherAndSubscriptionHolderTests: XCTestCase {
    private let watcher = PaginatedWatcherMock()
    private let cancellable = CancellableMock()

    func testWatcherIsCancelledOnDeinit() throws {
        // GIVEN
        var sut: PaginatedWatcherAndSubscriptionHolder? = .init(watcher: watcher)
        // WHEN
        sut = nil
        // THEN
        watcher.verify(.cancel())
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
    
    func testCancellablesAreCancelledOnDeinit() throws {
        // GIVEN
        var sut: PaginatedWatcherAndSubscriptionHolder? = .init(watcher: watcher)
        sut?.hold(cancellable)
        // WHEN
        sut = nil
        // THEN
        cancellable.verify(.cancel())
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
}
