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
        
        Date.nabla.now = { Date(timeIntervalSince1970: 0) }
    }

    func testAppointmentlistViewControllerUpcomingTab() {
        // GIVEN
        viewModel.given(.selectedSelector(getter: .upcoming))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.appointments(getter: [
            makeAppointment(state: .upcoming, date: .nabla.now()),
            makeAppointment(state: .upcoming, date: .nabla.now().adding(minutes: 9)),
            makeAppointment(state: .upcoming, date: .today.at(hour: 7, minute: 30)),
            makeAppointment(state: .upcoming, date: .tomorrow.at(hour: 14, minute: 0)),
            makeAppointment(state: .upcoming, date: .yesterday.at(hour: 18, minute: 50)),
        ]))
        // WHEN
        // THEN
        assertSnapshot(matching: navigationController, as: .almostSameImage)
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
        assertSnapshot(matching: navigationController, as: .almostSameImage)
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
