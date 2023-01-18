import Foundation
import UIKit

final class ScheduleAppointmentNavigationController: NavigationController {
    // MARK: Init

    init(
        factory: InternalSchedulingViewFactory
    ) {
        self.factory = factory
        super.init(rootViewController: UIViewController())
        setViewControllers([factory.createLocationPickerViewController(delegate: self)], animated: false)
    }

    // MARK: - Private

    private let factory: InternalSchedulingViewFactory
    private var selectedLocation: LocationType?
    private var selectedCategory: Category?
    
    private func replaceTopViewController(with viewController: UIViewController, animated _: Bool) {
        var viewControllers = viewControllers
        viewControllers.removeLast()
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: true)
    }
}

extension ScheduleAppointmentNavigationController: LocationPickerViewModelDelegate {
    func locationPickerViewModel(_: LocationPickerViewModel, didSkipStepWithSingleLocation location: LocationType) {
        selectedLocation = location
        let destination = factory.createCategoryPickerViewController(delegate: self)
        replaceTopViewController(with: destination, animated: true)
    }
    
    func locationPickerViewModel(_: LocationPickerViewModel, didSelect location: LocationType) {
        selectedLocation = location
        let destination = factory.createCategoryPickerViewController(delegate: self)
        pushViewController(destination, animated: true)
    }
}

extension ScheduleAppointmentNavigationController: CategoryPickerViewModelDelegate {
    func categoryPickerViewModel(_: CategoryPickerViewModel, didSelect category: Category) {
        selectedCategory = category
        guard let location = selectedLocation else { return }
        let destination = factory.createTimeSlotPickerViewController(location: location, category: category, delegate: self)
        pushViewController(destination, animated: true)
    }
}

extension ScheduleAppointmentNavigationController: TimeSlotPickerViewModelDelegate {
    func timeSlotPickerViewModel(_: TimeSlotPickerViewModel, didSelect timeSlot: AvailabilitySlot) {
        guard
            let location = selectedLocation,
            let category = selectedCategory
        else { return }
        let destination = factory.createAppointmentConfirmationViewController(
            location: location,
            category: category,
            timeSlot: timeSlot,
            delegate: self
        )
        pushViewController(destination, animated: true)
    }
}

extension ScheduleAppointmentNavigationController: AppointmentConfirmationViewModelDelegate {
    func appointmentConfirmationViewModel(_: AppointmentConfirmationViewModel, didConfirm _: Appointment) {
        dismiss(animated: true)
    }
}
