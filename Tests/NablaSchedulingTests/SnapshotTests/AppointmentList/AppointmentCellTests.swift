import Combine
@testable import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class AppointmentCellTests: XCTestCase {
    private var sut: AppointmentCell!
    
    private var viewModel: AppointmentCellViewModelMock!

    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = AppointmentCell(frame: .zero)
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
        
        viewModel.given(.avatar(getter: .init(url: nil, text: "TD")))
        viewModel.given(.title(getter: "Title"))
        viewModel.given(.subtitle(getter: "Subtitle"))
        viewModel.given(.enabled(getter: true))
        viewModel.given(.primaryActionTitle(getter: nil))
        viewModel.given(.showDisclosureIndicator(getter: false))
    }

    func testAppointmentCellDefaultThemeWithoutAction() {
        // GIVEN
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 84)))
    }
    
    func testAppointmentCellDefaultThemeLongTextsWithoutAction() {
        // GIVEN
        viewModel.given(.title(getter: "Some very long title that needs more than one line"))
        viewModel.given(.subtitle(getter: "The subtitle can also be very long but with an elipsis"))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
    
    func testAppointmentCellDefaultThemeDisabledWithoutAction() {
        // GIVEN
        viewModel.given(.enabled(getter: false))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 84)))
    }
    
    func testAppointmentCellDefaultThemeWithPrimaryAction() {
        // GIVEN
        viewModel.given(.primaryActionTitle(getter: "Action"))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 152)))
    }
    
    func testAppointmentCellDefaultThemeWithDisclosureIndicator() {
        // GIVEN
        viewModel.given(.showDisclosureIndicator(getter: true))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 84)))
    }

    func testAppointmentCellDefaultThemeWithPrimaryAndDisclosureIndicator() {
        // GIVEN
        viewModel.given(.primaryActionTitle(getter: "Action"))
        viewModel.given(.showDisclosureIndicator(getter: true))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 152)))
    }
    
    func testAppointmentCellDefaultThemeLongTextsWithAction() {
        // GIVEN
        viewModel.given(.title(getter: "Some very long title that needs more than one line"))
        viewModel.given(.subtitle(getter: "The subtitle can alos be very long but with an elipsis"))
        viewModel.given(.primaryActionTitle(getter: "Action"))
        viewModel.given(.showDisclosureIndicator(getter: true))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
    
    func testAppointmentCellDefaultThemeDisabledWithAction() {
        // GIVEN
        viewModel.given(.enabled(getter: false))
        viewModel.given(.primaryActionTitle(getter: "Action"))
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 152)))
    }
    
    func skip_testAppointmentCellCustomThemeEnabled() {
        // GIVEN
        NablaTheme.AppointmentListViewTheme.CellTheme.backgroundColor = .systemYellow
        NablaTheme.AppointmentListViewTheme.CellTheme.titleColor = .systemBlue
        NablaTheme.AppointmentListViewTheme.CellTheme.titleDisabledColor = .systemRed
        NablaTheme.AppointmentListViewTheme.CellTheme.titleFont = UIFont.nabla.regular(24)
        NablaTheme.AppointmentListViewTheme.CellTheme.subtitleColor = .systemBlue
        NablaTheme.AppointmentListViewTheme.CellTheme.subtitleDisabledColor = .systemRed
        NablaTheme.AppointmentListViewTheme.CellTheme.subtitleFont = UIFont.nabla.regular(20)
        NablaTheme.AppointmentListViewTheme.CellTheme.button.backgroundColor = .systemGreen
        NablaTheme.AppointmentListViewTheme.CellTheme.button.textColor = .white
        NablaTheme.AppointmentListViewTheme.CellTheme.button.font = UIFont.nabla.regular(22)
        let sut = AppointmentCell(frame: .zero)
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
    
    func skip_testAppointmentCellCustomThemeDisabled() {
        // GIVEN
        NablaTheme.AppointmentListViewTheme.CellTheme.backgroundColor = .systemYellow
        NablaTheme.AppointmentListViewTheme.CellTheme.titleColor = .systemBlue
        NablaTheme.AppointmentListViewTheme.CellTheme.titleDisabledColor = .systemRed
        NablaTheme.AppointmentListViewTheme.CellTheme.titleFont = UIFont.nabla.regular(24)
        NablaTheme.AppointmentListViewTheme.CellTheme.subtitleColor = .systemBlue
        NablaTheme.AppointmentListViewTheme.CellTheme.subtitleDisabledColor = .systemRed
        NablaTheme.AppointmentListViewTheme.CellTheme.subtitleFont = UIFont.nabla.regular(20)
        NablaTheme.AppointmentListViewTheme.CellTheme.button.backgroundColor = .systemGreen
        NablaTheme.AppointmentListViewTheme.CellTheme.button.textColor = .white
        NablaTheme.AppointmentListViewTheme.CellTheme.button.font = UIFont.nabla.regular(22)
        let sut = AppointmentCell(frame: .zero)
        // WHEN
        sut.viewModel = viewModel
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
    }
}
