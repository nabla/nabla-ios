import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class AppointmentDetailsViewControllerTests: XCTestCase {
    private var sut: AppointmentDetailsViewController!
    
    private var viewModel: AppointmentDetailsViewModelMock!
    private var navigationController: UINavigationController!
    
    private func makeReadyItem(
        caption: String = "Consultation planned on 1 January 1970 at 01:00",
        captionIcon: AppointmentDetailsView.CaptionIcon = .video,
        details1: String? = nil,
        details2: String? = nil,
        showCancelButton: Bool = true
    ) -> AppointmentsDetailsViewItem {
        .init(
            provider: Provider(
                id: .init(),
                prefix: "Mr",
                firstName: "John",
                lastName: "Doe",
                title: "Description",
                avatarUrl: nil
            ),
            caption: caption,
            captionIcon: captionIcon,
            details1: details1,
            details2: details2,
            showCancelButton: showCancelButton
        )
    }
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = AppointmentDetailsViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
    }
    
    func testAppointmentDetailsViewControllerLoading() {
        // GIVEN
        viewModel.given(.state(getter: .loading))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testAppointmentDetailsViewControllerForRemoteLocation() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            captionIcon: .house
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocation() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            captionIcon: .house,
            details1: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France"
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocationWithExtra() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            captionIcon: .house,
            details1: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France",
            details2: "Deuxième porte à gauche. Mais ce texte aussi devrait utiliser plusieurs lignes"
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerWithoutCancelButton() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            showCancelButton: false
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
}
