import NablaCore
import UIKit

public protocol NablaSchedulingViewFactory: SchedulingViewFactory {
    func createAppointmentListViewController(delegate: AppointmentListDelegate) -> UIViewController
    func presentScheduleAppointmentNavigationController(
        from presentingViewController: UIViewController,
        delegate: ScheduleAppointmentDelegate
    )
    func createAppointmentDetailsViewController(appointmentId: UUID, delegate: AppointmentDetailsDelegate) -> UIViewController
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
        appointment: Appointment,
        delegate: AppointmentConfirmationViewModelDelegate
    ) -> UIViewController
    func createSuccessViewController(
        delegate: SuccessViewModelDelegate
    ) -> UIViewController
    
    @MainActor func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel
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

    public func presentScheduleAppointmentNavigationController(
        from presentingViewController: UIViewController,
        delegate: ScheduleAppointmentDelegate
    ) {
        let viewController = ScheduleAppointmentNavigationController(factory: self, delegate: delegate)
        presentingViewController.present(viewController, animated: true)
    }
    
    public func createAppointmentDetailsViewController(appointmentId: UUID, delegate: AppointmentDetailsDelegate) -> UIViewController {
        let viewModel = AppointmentDetailsViewModelImpl(
            appointmentId: appointmentId,
            delegate: delegate,
            client: client,
            addressFormatter: client.container.addressFormatter,
            universalLinkGenerator: client.container.universalLinkGenerator
        )
        let viewController = AppointmentDetailsViewController(viewModel: viewModel)
        viewController.navigationItem.largeTitleDisplayMode = .never
        return viewController
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
        appointment: Appointment,
        delegate: AppointmentConfirmationViewModelDelegate
    ) -> UIViewController {
        let viewModel = AppointmentConfirmationViewModelImpl(
            appointment: appointment,
            client: client,
            addressFormatter: client.container.addressFormatter,
            universalLinkGenerator: client.container.universalLinkGenerator,
            logger: client.container.logger,
            delegate: delegate
        )
        return AppointmentConfirmationViewController(viewModel: viewModel)
    }
    
    func createSuccessViewController(delegate: SuccessViewModelDelegate) -> UIViewController {
        let viewModel = SuccessViewModelImpl(delegate: delegate)
        return SuccessViewController(viewModel: viewModel)
    }
    
    @MainActor func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel {
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
