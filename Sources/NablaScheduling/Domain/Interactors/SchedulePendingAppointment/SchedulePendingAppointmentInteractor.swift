import Combine
import Foundation

protocol SchedulePendingAppointmentInteractor {
    func execute(appointmentId: UUID) async throws -> Appointment
}
