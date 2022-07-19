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

    func testCancellableIsCancelledOnDeinit() throws {
        // GIVEN
        var sut: UmbrellaCancellable? = .init()
        sut?.add(cancellable)
        // WHEN
        sut = nil
        // THEN
        cancellable.verify(.cancel())
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
}
