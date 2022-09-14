import Foundation
import NablaCore
import Combine

protocol AppointmentRepository {
    func watchAppointments(state: Appointment.State) -> AnyPublisher<PaginatedList<Appointment>, NablaError>
    /// Throws `NablaError`
    func scheduleAppointment(categoryId: UUID, providerId: UUID, date: Date) async throws -> Appointment
    /// Throws `NablaError`
    func cancelAppointment(withId: UUID) async throws
}
