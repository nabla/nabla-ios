import NablaCore
import SnapshotTesting
import XCTest

final class PrimaryButtonTests: XCTestCase {
    private var sut: NablaViews.PrimaryButton!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    func testPrimaryButton_enabled() {
        // GIVEN
        // WHEN
        sut.title = "Primary Button"
        // THEN
        assertSnapshot(matching: sut, as: .image())
    }
    
    func testPrimaryButton_disabled() {
        // GIVEN
        // WHEN
        sut.title = "Primary Button"
        sut.isEnabled = false
        // THEN
        assertSnapshot(matching: sut, as: .image())
    }
    
    func testPrimaryButton_loading() {
        // GIVEN
        // WHEN
        sut.title = "Primary Button"
        sut.isLoading = true
        // THEN
        assertSnapshot(matching: sut, as: .image())
    }
    
    func testPrimaryButton_highlighted() {
        // GIVEN
        // WHEN
        sut.title = "Primary Button"
        sut.isHighlighted = true
        // THEN
        assertSnapshot(matching: sut, as: .image())
    }
}
