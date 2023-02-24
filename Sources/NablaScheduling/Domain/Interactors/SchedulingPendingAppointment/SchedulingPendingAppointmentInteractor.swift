import Combine
import Foundation

protocol SchedulingPendingAppointmentInteractor {
    func execute(appointmentId: UUID) async throws -> Appointment
}
