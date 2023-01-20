import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class LocationCellTests: XCTestCase {
    private let size = CGSize(width: 320, height: 56)
    private var sut: LocationCell!

    override func setUp() {
        super.setUp()
        sut = LocationCell(frame: .zero)
    }

    func testLocationCellDefaultTheme() {
        // GIVEN
        // WHEN
        sut.text = "Location"
        sut.icon = .nabla.symbol(.house)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testLocationCellDefaultThemeWithLongText() {
        // GIVEN
        // WHEN
        sut.text = "Some very long string that will not fit on a single line and will overflow."
        sut.icon = .nabla.symbol(.video)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
    
    func skip_testLocationCellCustomThemeEnabled() {
        // GIVEN
        NablaTheme.LocationPickerViewTheme.CellTheme.textColor = .yellow
        NablaTheme.LocationPickerViewTheme.CellTheme.font = UIFont.nabla.regular(24)
        NablaTheme.LocationPickerViewTheme.CellTheme.backgroundColor = .red
        NablaTheme.LocationPickerViewTheme.CellTheme.indicatorColor = .green
        let sut = LocationCell(frame: .zero)
        // WHEN
        sut.text = "Location"
        sut.icon = .nabla.symbol(.microphone)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
}
