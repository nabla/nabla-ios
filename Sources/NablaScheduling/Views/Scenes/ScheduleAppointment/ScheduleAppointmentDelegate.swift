import Foundation
import UIKit

public protocol ScheduleAppointmentDelegate: AnyObject {
    /// This method will be called when the user confirms an appointment with some `Appointment.PaymentRequirement`.
    /// You must return a `UIViewController` that displays instruction to proceed with the payment.
    /// Once the payment is done, and your backend did update the appointment, call the `completion` handler.
    /// You can return some `UINavigationController`, but let the SDK handle the presentation and dismissal of this controller.
    /// This method is optional, but you must implement it to support paid appointments.
    @MainActor func paymentViewController(for appointment: Appointment, completion: @escaping (Result<Void, Error>) -> Void) -> UIViewController
    
    @MainActor func scheduleAppointmentDidSucceed(with appointment: Appointment)
}

public extension ScheduleAppointmentDelegate {
    func paymentViewController(for _: Appointment, completion: @escaping (Result<Void, Error>) -> Void) -> UIViewController {
        assertionFailure("\(type(of: self)) does not implement `paymentViewController(for:completion:)` but this method is mandatory to support paid appointments.")
        let alert = UIAlertController(
            title: L10n.confirmationScreenPaymentHookNotImplementedErrorTitle,
            message: L10n.confirmationScreenPaymentHookNotImplementedErrorMessage,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: L10n.confirmationScreenPaymentHookNotImplementedErrorButton, style: .cancel) { _ in
            completion(.failure(NotImplementedError()))
        }
        alert.addAction(cancel)
        return alert
    }
}

private class NotImplementedError: Error {}
