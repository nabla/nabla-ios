import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class CategoryCellTests: XCTestCase {
    private let size = CGSize(width: 320, height: 56)
    private var sut: CategoryCell!

    override func setUp() {
        super.setUp()
        sut = CategoryCell(frame: .zero)
    }

    func testCategoryCellDefaultTheme() {
        // GIVEN
        // WHEN
        sut.text = "Category"
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testCategoryCellDefaultThemeWithLongText() {
        // GIVEN
        // WHEN
        sut.text = "Some very long string that will not fit on a single line and will overflow."
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
    
    func skip_testCategoryCellCustomThemeEnabled() {
        // GIVEN
        NablaTheme.CategoryPickerViewTheme.CellTheme.textColor = .yellow
        NablaTheme.CategoryPickerViewTheme.CellTheme.font = UIFont.nabla.regular(24)
        NablaTheme.CategoryPickerViewTheme.CellTheme.backgroundColor = .red
        NablaTheme.CategoryPickerViewTheme.CellTheme.indicatorColor = .green
        let sut = CategoryCell(frame: .zero)
        // WHEN
        sut.text = "Category"
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
}
