import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class AppointmentDetailsViewControllerTests: XCTestCase {
    private var sut: AppointmentDetailsViewController!
    
    private var viewModel: AppointmentDetailsViewModelMock!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = AppointmentDetailsViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
        
        viewModel.given(
            .provider(getter:
                Provider(
                    id: .init(),
                    prefix: "Mr",
                    firstName: "John",
                    lastName: "Doe",
                    title: "Description",
                    avatarUrl: nil
                )))
        viewModel.given(.caption(getter: "Consultation planned on 1 January 1970 at 01:00"))
        viewModel.given(.captionIcon(getter: .video))
        viewModel.given(.showCancelButton(getter: true))
    }

    func testAppointmentDetailsViewControllerForRemoteLocation() {
        // GIVEN
        viewModel.given(.captionIcon(getter: .video))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocation() {
        // GIVEN
        viewModel.given(.captionIcon(getter: .house))
        viewModel.given(.details1(getter: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France"))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocationWithExtra() {
        // GIVEN
        viewModel.given(.captionIcon(getter: .house))
        viewModel.given(.details1(getter: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France"))
        viewModel.given(.details2(getter: "Deuxième porte à gauche. Mais ce texte aussi devrait utiliser plusieurs lignes"))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerWithoutCancelButton() {
        // GIVEN
        viewModel.given(.showCancelButton(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
}
