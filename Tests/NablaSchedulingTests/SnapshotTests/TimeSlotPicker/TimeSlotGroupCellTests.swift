import NablaCore
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class TimeSlotGroupCellTests: XCTestCase {
    private let size = CGSize(width: 320, height: 51)
    private var sut: TimeSlotGroupCell!

    override func setUp() {
        super.setUp()
        sut = TimeSlotGroupCell(frame: .zero)
    }

    func testTimeSlotGroupCellDefaultThemeClosed() {
        // GIVEN
        // WHEN
        sut.title = "Title"
        sut.subtitle = "Subtitle"
        sut.isOpened = false
        sut.timeSlots = [
            .init(date: Date(timeIntervalSince1970: 0), selected: false),
            .init(date: Date(timeIntervalSince1970: 30 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 60 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 90 * 60), selected: false),
        ]
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 80)))
    }
    
    func testTimeSlotGroupCellDefaultThemeOpened() {
        // GIVEN
        // WHEN
        sut.title = "Title"
        sut.subtitle = "Subtitle"
        sut.isOpened = true
        sut.timeSlots = [
            .init(date: Date(timeIntervalSince1970: 0), selected: false),
            .init(date: Date(timeIntervalSince1970: 30 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 60 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 90 * 60), selected: false),
        ]
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 146)))
    }
    
    func testTimeSlotGroupCellDefaultThemeSelected() {
        // GIVEN
        // WHEN
        sut.title = "Title"
        sut.subtitle = "Subtitle"
        sut.isOpened = true
        sut.timeSlots = [
            .init(date: Date(timeIntervalSince1970: 0), selected: false),
            .init(date: Date(timeIntervalSince1970: 30 * 60), selected: true),
            .init(date: Date(timeIntervalSince1970: 60 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 90 * 60), selected: false),
        ]
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 146)))
    }
    
    func testTimeSlotGroupCellDefaultThemeClosedLongTexts() {
        // GIVEN
        // WHEN
        sut.title = "Some very long title that should not fit on the first line"
        sut.subtitle = "The subtitle will be long enough not to fit either"
        sut.isOpened = false
        sut.timeSlots = [
            .init(date: Date(timeIntervalSince1970: 0), selected: false),
            .init(date: Date(timeIntervalSince1970: 30 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 60 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 90 * 60), selected: false),
        ]
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 80)))
    }
    
    func testTimeSlotGroupCellDefaultThemeOpenedLongTexts() {
        // GIVEN
        // WHEN
        sut.title = "Some very long title that should not fit on the first line"
        sut.subtitle = "The subtitle will be long enough not to fit either"
        sut.isOpened = true
        sut.timeSlots = [
            .init(date: Date(timeIntervalSince1970: 0), selected: false),
            .init(date: Date(timeIntervalSince1970: 30 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 60 * 60), selected: false),
            .init(date: Date(timeIntervalSince1970: 90 * 60), selected: false),
        ]
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 146)))
    }
}
