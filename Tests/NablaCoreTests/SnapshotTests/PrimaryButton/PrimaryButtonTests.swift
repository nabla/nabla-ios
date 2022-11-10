import NablaCore
import NablaCoreTestsUtils
import SnapshotTesting
import XCTest

final class PrimaryButtonTests: XCTestCase {
    private var sut: NablaViews.PrimaryButton!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    func testBaseButtonEnabled() {
        // GIVEN
        sut.theme = NablaTheme.Button.base
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testBaseButtonDisabled() {
        // GIVEN
        sut.theme = NablaTheme.Button.base
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isEnabled = false
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testBaseButtonLoading() {
        // GIVEN
        sut.theme = NablaTheme.Button.base
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isLoading = true
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testBaseButtonHighlighted() {
        // GIVEN
        sut.theme = NablaTheme.Button.base
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isHighlighted = true
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentButtonEnabled() {
        // GIVEN
        sut.theme = NablaTheme.Button.accent
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentButtonDisabled() {
        // GIVEN
        sut.theme = NablaTheme.Button.accent
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isEnabled = false
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentButtonLoading() {
        // GIVEN
        sut.theme = NablaTheme.Button.accent
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isLoading = true
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentButtonHighlighted() {
        // GIVEN
        sut.theme = NablaTheme.Button.accent
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isHighlighted = true
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentSubduedButtonEnabled() {
        // GIVEN
        sut.theme = NablaTheme.Button.accentSubdued
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentSubduedButtonDisabled() {
        // GIVEN
        sut.theme = NablaTheme.Button.accentSubdued
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isEnabled = false
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentSubduedButtonLoading() {
        // GIVEN
        sut.theme = NablaTheme.Button.accentSubdued
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isLoading = true
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testAccentSubduedButtonHighlighted() {
        // GIVEN
        sut.theme = NablaTheme.Button.accentSubdued
        // WHEN
        sut.setTitle("Primary Button", for: .normal)
        sut.isHighlighted = true
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
}
