import NablaCore
import NablaCoreTestsUtils
import SnapshotTesting
import XCTest

final class RefreshingIndicatorViewTests: XCTestCase {
    private var sut: NablaViews.RefreshingIndicatorView!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    func testView() {
        // GIVEN
        // WHEN
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: .init(width: 200, height: 44)))
    }
}
