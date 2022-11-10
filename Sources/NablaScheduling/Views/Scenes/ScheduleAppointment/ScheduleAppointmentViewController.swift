import Foundation
import UIKit

final class ScheduleAppointmentViewController: NavigationController {
    // MARK: Init

    init(
        factory: InternalSchedulingViewFactory
    ) {
        self.factory = factory
        super.init(rootViewController: UIViewController())
        setViewControllers([factory.createCategoryPickerViewController(delegate: self)], animated: false)
    }

    // MARK: - Private

    private let factory: InternalSchedulingViewFactory
    private var selectedCategory: Category?
}

extension ScheduleAppointmentViewController: CategoryPickerViewModelDelegate {
    func categoryPickerViewModel(_: CategoryPickerViewModel, didSelect category: Category) {
        selectedCategory = category
        let destination = factory.createTimeSlotPickerViewController(category: category, delegate: self)
        pushViewController(destination, animated: true)
    }
}

extension ScheduleAppointmentViewController: TimeSlotPickerViewModelDelegate {
    func timeSlotPickerViewModel(_: TimeSlotPickerViewModel, didSelect timeSlot: AvailabilitySlot) {
        guard let category = selectedCategory else { return }
        let destination = factory.createAppointmentConfirmationViewController(
            category: category,
            timeSlot: timeSlot,
            delegate: self
        )
        pushViewController(destination, animated: true)
    }
}

extension ScheduleAppointmentViewController: AppointmentConfirmationViewModelDelegate {
    func appointmentConfirmationViewModel(_: AppointmentConfirmationViewModel, didConfirm _: Appointment) {
        dismiss(animated: true)
    }
}
