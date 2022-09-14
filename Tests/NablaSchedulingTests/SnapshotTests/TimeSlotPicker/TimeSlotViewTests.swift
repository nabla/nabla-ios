@testable import NablaScheduling
import SnapshotTesting
import XCTest

class TimeSlotViewTests: XCTestCase {
    private var sut: TimeSlotView!
    
    override func setUp() {
        super.setUp()
        
        sut = TimeSlotView(frame: .zero)
    }

    func testTimeSlotViewDefaultTheme1970() {
        // GIVEN
        // WHEN
        sut.date = Date(timeIntervalSince1970: 0)
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 103, height: 31)))
    }
    
    func testTimeSlotViewDefaultTheme1970And30Min() {
        // GIVEN
        // WHEN
        sut.date = Date(timeIntervalSince1970: 30 * 60)
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 103, height: 31)))
    }
    
    func testTimeSlotViewDefaultTheme1970Selected() {
        // GIVEN
        // WHEN
        sut.date = Date(timeIntervalSince1970: 0)
        sut.isSelected = true
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 103, height: 31)))
    }
    
    func testTimeSlotViewDefaultTheme1970And30MinSelected() {
        // GIVEN
        // WHEN
        sut.date = Date(timeIntervalSince1970: 30 * 60)
        sut.isSelected = true
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 103, height: 31)))
    }
}
