import Foundation
import UIKit

final class ScheduleAppointmentNavigationController: NavigationController {
    // MARK: - Internal
    
    weak var scheduleAppointmentDelegate: ScheduleAppointmentDelegate?
    
    // MARK: Init

    init(
        factory: InternalSchedulingViewFactory,
        delegate: ScheduleAppointmentDelegate
    ) {
        self.factory = factory
        scheduleAppointmentDelegate = delegate
        super.init(rootViewController: UIViewController())
        setViewControllers([factory.createLocationPickerViewController(delegate: self)], animated: false)
    }

    // MARK: - Private

    private let factory: InternalSchedulingViewFactory
    private var selectedLocation: LocationType?
    private var selectedCategory: Category?
    
    private func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        var viewControllers = viewControllers
        viewControllers.removeLast()
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: animated)
    }
}

extension ScheduleAppointmentNavigationController: LocationPickerViewModelDelegate {
    func locationPickerViewModel(_: LocationPickerViewModel, didSkipStepWithSingleLocation location: LocationType) {
        selectedLocation = location
        let destination = factory.createCategoryPickerViewController(preselectedLocation: location, delegate: self)
        replaceTopViewController(with: destination, animated: false)
    }
    
    func locationPickerViewModel(_: LocationPickerViewModel, didSelect location: LocationType) {
        selectedLocation = location
        let destination = factory.createCategoryPickerViewController(preselectedLocation: nil, delegate: self)
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
    func timeSlotPickerViewModel(_: TimeSlotPickerViewModel, didSelect appointment: Appointment) {
        let destination = factory.createAppointmentConfirmationViewController(
            appointment: appointment,
            delegate: self
        )
        pushViewController(destination, animated: true)
    }
}

extension ScheduleAppointmentNavigationController: AppointmentConfirmationViewModelDelegate {
    func appointmentConfirmationViewModel(_: AppointmentConfirmationViewModel, confirm appointment: Appointment) async throws {
        guard isPaymentRequired(for: appointment) else {
            return
        }
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            var modal: UIViewController?
            modal = scheduleAppointmentDelegate?.paymentViewController(for: appointment) { result in
                modal?.dismiss(animated: true) {
                    continuation.resume(with: result)
                }
            }
            guard let modal = modal else {
                continuation.resume(with: .success(()))
                return
            }
            modal.modalPresentationStyle = .fullScreen // Prevents unhandled swipe to close gestures.
            present(modal, animated: true)
        }
    }
    
    private func isPaymentRequired(for appointment: Appointment) -> Bool {
        switch appointment.state {
        case let .pending(paymentRequirement): return paymentRequirement != nil
        case .finalized, .scheduled: return false
        }
    }
    
    func appointmentConfirmationViewModel(_: AppointmentConfirmationViewModel, didConfirm appointment: Appointment) {
        let destination = factory.createSuccessViewController(
            appointment: appointment,
            delegate: self
        )
        setViewControllers([destination], animated: true)
    }
}

extension ScheduleAppointmentNavigationController: SuccessViewModelDelegate {
    func successViewModel(_: SuccessViewModel, didConfirm appointment: Appointment) {
        scheduleAppointmentDelegate?.scheduleAppointmentDidSucceed(with: appointment)
    }
}
