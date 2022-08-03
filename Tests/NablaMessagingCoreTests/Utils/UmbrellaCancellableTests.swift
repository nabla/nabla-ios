@testable import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import XCTest

class UmbrellaCancellableTests: XCTestCase {
    private let cancellable = CancellableMock()
    
    func testIsCancelledAfterCancel() throws {
        // GIVEN
        let sut = UmbrellaCancellable()
        // WHEN
        sut.cancel()
        // THEN
        XCTAssertTrue(sut.isCancelled)
    }

    func testCancellablesAreReleasedOnDeinit() throws {
        // GIVEN
        
        // Make a strong `cancellable` for set up, but only keep a `weak` reference on it during the test.
        var cancellable: Cancellable? = CancellableMock()
        weak var weakCancellable = cancellable
        
        var sut: UmbrellaCancellable? = .init()
        // swiftlint:disable:next force_unwrapping
        sut?.add(cancellable!)
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
