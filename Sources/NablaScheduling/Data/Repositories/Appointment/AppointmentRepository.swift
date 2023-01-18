import Combine
import Foundation
import NablaCore

protocol AppointmentRepository {
    func watchAppointments(state: Appointment.State) -> AnyPublisher<PaginatedList<Appointment>, NablaError>
    /// - Throws: ``NablaError``
    func scheduleAppointment(
        location: LocationType,
        categoryId: UUID,
        providerId: UUID,
        date: Date
    ) async throws -> Appointment
    /// - Throws: ``NablaError``
    func cancelAppointment(withId: UUID) async throws
    /// - Throws: ``NablaError``
    func getAvailableAppointmentLocations() async throws -> Set<LocationType>
}
