import Combine
@testable import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class AppointmentlistViewControllerTests: XCTestCase {
    private var sut: AppointmentListViewController!
    
    private var viewModel: AppointmentListViewModelMock!
    private var factory: MockFactory!
    private var logger: LoggerMock!
    private var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()
        viewModel = .init()
        factory = .init()
        logger = .init()
        sut = AppointmentListViewController(
            viewModel: viewModel,
            factory: factory,
            logger: logger,
            videoCallClient: nil
        )
        navigationController = UINavigationController(rootViewController: sut)
        navigationController.navigationBar.prefersLargeTitles = true
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.modal(getter: nil))
    }

    func testAppointmentlistViewControllerUpcomingTabWithImminentAppointments() {
        // GIVEN
        viewModel.given(.selectedSelector(getter: .upcoming))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.appointments(getter: [
            makeAppointment(state: .upcoming, date: .nabla.now()),
            makeAppointment(state: .upcoming, date: .nabla.now().adding(minutes: 9)),
            makeAppointment(state: .upcoming, date: .nabla.now().adding(minutes: -9)),
        ]))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages(tolerant: true))
    }
    
    func testAppointmentlistViewControllerUpcomingTabWithFarAppointments() {
        // GIVEN
        viewModel.given(.selectedSelector(getter: .upcoming))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.appointments(getter: [
            makeAppointment(state: .upcoming, date: .init(timeIntervalSince1970: 1979286455)), // 2032
            makeAppointment(state: .upcoming, date: .init(timeIntervalSince1970: 906285296)), // 1998
        ]))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages(tolerant: true))
    }
    
    func testAppointmentlistViewControllerFinalizedTab() {
        // GIVEN
        viewModel.given(.selectedSelector(getter: .finalized))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.appointments(getter: (0 ... 10).map { (index: Int) -> Appointment in
            makeAppointment(state: .finalized, date: .nabla.now().adding(minutes: index))
        }))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages(tolerant: true))
    }
    
    private func makeAppointment(state: Appointment.State, date: Date) -> Appointment {
        Appointment(
            id: .init(),
            state: state,
            start: date,
            provider: .init(
                id: .init(),
                prefix: "Dr",
                firstName: "FirstName",
                lastName: "LastName",
                title: "GP",
                avatarUrl: nil
            ),
            videoCallRoom: state == .finalized ? nil : .init(
                url: "",
                token: ""
            )
        )
    }
}

private class MockFactory: InternalSchedulingViewFactoryMock {
    override func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel {
        AppointmentCellViewModelImpl(appointment: appointment, videoCallClient: nil, delegate: delegate)
    }
}

extension MockFactory: NablaSchedulingViewFactory {
    func createAppointmentListViewController() -> UIViewController {
        fatalError()
    }
    
    func presentScheduleAppointmentViewController(from _: UIViewController) {
        fatalError()
    }
}
