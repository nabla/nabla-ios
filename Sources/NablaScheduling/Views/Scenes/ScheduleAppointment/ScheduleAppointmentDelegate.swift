import Foundation
import UIKit

public protocol ScheduleAppointmentDelegate: AnyObject {
    /// This method will be called when the user confirms an appointment with some `Appointment.PaymentRequirement`.
    /// You must return a `UIViewController` that displays instruction to proceed with the payment.
    /// Once the payment is done, and your backend did update the appointment, call the `completion` handler.
    /// You can return some `UINavigationController`, but let the SDK handle the presentation and dismissal of this controller.
    func paymentViewController(for appointment: Appointment, completion: @escaping (Result<Void, Error>) -> Void) -> UIViewController
    
    func scheduleAppointmentDidSucceed(with appointment: Appointment)
}
