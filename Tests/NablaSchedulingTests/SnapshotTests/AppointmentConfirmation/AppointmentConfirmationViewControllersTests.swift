import Combine
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class AppointmentConfirmationViewControllerTests: XCTestCase {
    private var sut: AppointmentConfirmationViewController!
    
    private var viewModel: AppointmentConfirmationViewModelMock!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = AppointmentConfirmationViewController(viewModel: viewModel)
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
        viewModel.given(.appointmentDate(getter: .init(timeIntervalSince1970: 0)))
    }

    func testAppointmentConfirmationViewControllerUnchecked() {
        // GIVEN
        viewModel.given(.agreesWithConsultationDisclaimer(getter: false))
        viewModel.given(.agreesWithPersonalDataDisclaimer(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshot(matching: navigationController, as: .image)
    }
    
    func testAppointmentConfirmationViewControllerPartialyChecked() {
        // GIVEN
        viewModel.given(.agreesWithConsultationDisclaimer(getter: true))
        viewModel.given(.agreesWithPersonalDataDisclaimer(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshot(matching: navigationController, as: .image)
    }
    
    func testAppointmentConfirmationViewControllerChecked() {
        // GIVEN
        viewModel.given(.agreesWithConsultationDisclaimer(getter: true))
        viewModel.given(.agreesWithPersonalDataDisclaimer(getter: true))
        viewModel.given(.canConfirm(getter: true))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshot(matching: navigationController, as: .image)
    }
    
    func testAppointmentConfirmationViewControllerLoading() {
        // GIVEN
        viewModel.given(.agreesWithConsultationDisclaimer(getter: true))
        viewModel.given(.agreesWithPersonalDataDisclaimer(getter: true))
        viewModel.given(.canConfirm(getter: true))
        viewModel.given(.isConfirming(getter: true))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshot(matching: navigationController, as: .image)
    }
    
    func testAppointmentConfirmationViewControllerWithoutProviderDescription() {
        // GIVEN
        viewModel.given(
            .provider(getter:
                Provider(
                    id: .init(),
                    prefix: "Mr",
                    firstName: "John",
                    lastName: "Doe",
                    title: nil,
                    avatarUrl: nil
                )))
        viewModel.given(.agreesWithConsultationDisclaimer(getter: false))
        viewModel.given(.agreesWithPersonalDataDisclaimer(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshot(matching: navigationController, as: .image)
    }
}
