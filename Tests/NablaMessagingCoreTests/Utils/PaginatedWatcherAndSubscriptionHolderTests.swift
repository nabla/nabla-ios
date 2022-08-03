@testable import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import XCTest

class PaginatedWatcherAndSubscriptionHolderTests: XCTestCase {
    private let watcher = PaginatedWatcherMock()

    func testWatcherIsCancelledOnDeinit() throws {
        // GIVEN
        var sut: PaginatedWatcherAndSubscriptionHolder? = .init(watcher: watcher)
        // WHEN
        sut = nil
        // THEN
        watcher.verify(.cancel())
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
    
    func testCancellablesAreReleasedOnDeinit() throws {
        // GIVEN
        
        // Make a strong `cancellable` for set up, but only keep a `weak` reference on it during the test.
        var cancellable: Cancellable? = CancellableMock()
        weak var weakCancellable = cancellable
        
        var sut: PaginatedWatcherAndSubscriptionHolder? = .init(watcher: watcher)
        // swiftlint:disable:next force_unwrapping
        sut?.hold(cancellable!)
        cancellable = nil
        
        // Assert test will run in expected conditions
        XCTAssertNil(cancellable)
        XCTAssertNotNil(weakCancellable)
        
        // WHEN
        sut = nil
        
        // THEN
        XCTAssertNil(weakCancellable)
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
}
