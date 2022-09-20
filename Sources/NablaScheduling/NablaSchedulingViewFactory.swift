import NablaCore
import UIKit

public protocol NablaSchedulingViewFactory: SchedulingViewFactory {
    func createAppointmentListViewController() -> UIViewController
    func presentScheduleAppointmentViewController(from presentingViewController: UIViewController)
}

// sourcery: AutoMockable
// sourcery: typealias = "Category = NablaScheduling.Category"
protocol InternalSchedulingViewFactory {
    func createCategoryPickerViewController(delegate: CategoryPickerViewModelDelegate) -> UIViewController
    func createTimeSlotPickerViewController(category: Category, delegate: TimeSlotPickerViewModelDelegate) -> UIViewController
    func createAppointmentConfirmationViewController(
        category: Category,
        timeSlot: AvailabilitySlot,
        delegate: AppointmentConfirmationViewModelDelegate
    ) -> UIViewController
    
    func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel
}

public class NablaSchedulingViewFactoryImpl: NablaSchedulingViewFactory, InternalSchedulingViewFactory {
    // MARK: - Public
    
    public func createAppointmentListViewController() -> UIViewController {
        let viewModel = AppointmentListViewModelImpl(client: client)
        let viewController = AppointmentListViewController(
            viewModel: viewModel,
            factory: self,
            logger: client.container.logger,
            videoCallClient: client.container.videoCallClient
        )
        viewModel.delegate = viewController // The navigation is currently handled by the root view controller him self
        return viewController
    }

    public func presentScheduleAppointmentViewController(from presentingViewController: UIViewController) {
        let viewController = ScheduleAppointmentViewController(factory: self)
        presentingViewController.present(viewController, animated: true)
    }

    // MARK: - Internal
    
    func createCategoryPickerViewController(delegate: CategoryPickerViewModelDelegate) -> UIViewController {
        let viewModel = CategoryPickerViewModelImpl(client: client, delegate: delegate)
        return CategoryPickerViewController(viewModel: viewModel)
    }
    
    func createTimeSlotPickerViewController(category: Category, delegate: TimeSlotPickerViewModelDelegate) -> UIViewController {
        let viewModel = TimeSlotPickerViewModelImpl(
            category: category,
            client: client,
            delegate: delegate
        )
        return TimeSlotPickerViewController(viewModel: viewModel)
    }
    
    func createAppointmentConfirmationViewController(
        category: Category,
        timeSlot: AvailabilitySlot,
        delegate: AppointmentConfirmationViewModelDelegate
    ) -> UIViewController {
        let viewModel = AppointmentConfirmationViewModelImpl(
            category: category,
            timeSlot: timeSlot,
            client: client,
            delegate: delegate
        )
        return AppointmentConfirmationViewController(viewModel: viewModel)
    }
    
    func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel {
        AppointmentCellViewModelImpl(
            appointment: appointment,
            videoCallClient: client.container.videoCallClient,
            delegate: delegate
        )
    }
    
    // MARK: Initializer
    
    init(
        client: NablaSchedulingClient
    ) {
        self.client = client
    }
    
    // MARK: - Private
    
    private let client: NablaSchedulingClient
}
