import NablaCore
import UIKit

public protocol NablaSchedulingViewFactory: SchedulingViewFactory {
    func createAppointmentListViewController(delegate: AppointmentListDelegate) -> UIViewController
    func presentScheduleAppointmentNavigationController(from presentingViewController: UIViewController)
    func createAppointmentDetailsViewController(appointment: Appointment, delegate: AppointmentDetailsDelegate) -> UIViewController
}

// sourcery: AutoMockable
// sourcery: typealias = "Category = NablaScheduling.Category"
protocol InternalSchedulingViewFactory {
    func createLocationPickerViewController(delegate: LocationPickerViewModelDelegate) -> UIViewController
    func createCategoryPickerViewController(
        preselectedLocation: LocationType?,
        delegate: CategoryPickerViewModelDelegate
    ) -> UIViewController
    func createTimeSlotPickerViewController(
        location: LocationType,
        category: Category,
        delegate: TimeSlotPickerViewModelDelegate
    ) -> UIViewController
    func createAppointmentConfirmationViewController(
        location: LocationType,
        category: Category,
        timeSlot: AvailabilitySlot,
        delegate: AppointmentConfirmationViewModelDelegate
    ) -> UIViewController
    
    func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel
}

public class NablaSchedulingViewFactoryImpl: NablaSchedulingViewFactory, InternalSchedulingViewFactory {
    // MARK: - Public
    
    public func createAppointmentListViewController(delegate: AppointmentListDelegate) -> UIViewController {
        let viewModel = AppointmentListViewModelImpl(
            delegate: delegate,
            client: client,
            logger: client.container.logger
        )
        let viewController = AppointmentListViewController(
            viewModel: viewModel,
            factory: self,
            logger: client.container.logger,
            videoCallClient: client.container.videoCallClient
        )
        return viewController
    }

    public func presentScheduleAppointmentNavigationController(from presentingViewController: UIViewController) {
        let viewController = ScheduleAppointmentNavigationController(factory: self)
        presentingViewController.present(viewController, animated: true)
    }
    
    public func createAppointmentDetailsViewController(appointment: Appointment, delegate: AppointmentDetailsDelegate) -> UIViewController {
        let viewModel = AppointmentDetailsViewModelImpl(
            appointment: appointment,
            delegate: delegate,
            client: client,
            addressFormatter: client.container.addressFormatter,
            universalLinkGenerator: client.container.universalLinkGenerator
        )
        let viewController = AppointmentDetailsViewController(viewModel: viewModel)
        viewController.navigationItem.largeTitleDisplayMode = .never
        return viewController
    }

    // MARK: - Internal
    
    func createLocationPickerViewController(delegate: LocationPickerViewModelDelegate) -> UIViewController {
        let viewModel = LocationPickerViewModelImpl(delegate: delegate, client: client)
        return LocationPickerViewController(viewModel: viewModel)
    }
    
    func createCategoryPickerViewController(
        preselectedLocation: LocationType?,
        delegate: CategoryPickerViewModelDelegate
    ) -> UIViewController {
        let viewModel = CategoryPickerViewModelImpl(
            preselectedLocation: preselectedLocation,
            client: client,
            delegate: delegate
        )
        return CategoryPickerViewController(viewModel: viewModel)
    }
    
    func createTimeSlotPickerViewController(
        location: LocationType,
        category: Category,
        delegate: TimeSlotPickerViewModelDelegate
    ) -> UIViewController {
        let viewModel = TimeSlotPickerViewModelImpl(
            location: location,
            category: category,
            client: client,
            delegate: delegate
        )
        return TimeSlotPickerViewController(viewModel: viewModel)
    }
    
    func createAppointmentConfirmationViewController(
        location: LocationType,
        category: Category,
        timeSlot: AvailabilitySlot,
        delegate: AppointmentConfirmationViewModelDelegate
    ) -> UIViewController {
        let viewModel = AppointmentConfirmationViewModelImpl(
            category: category,
            timeSlot: timeSlot,
            location: location,
            client: client,
            addressFormatter: client.container.addressFormatter,
            universalLinkGenerator: client.container.universalLinkGenerator,
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
