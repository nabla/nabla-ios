import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol AppointmentRepository {
    func watchAppointments(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError>
    func watchAppointment(withId id: UUID) -> AnyPublisher<Appointment, NablaError>
    /// - Throws: ``NablaError``
    func createPendingAppointment(
        location: LocationType,
        categoryId: UUID,
        providerId: UUID,
        date: Date
    ) async throws -> Appointment
    /// - Throws: ``NablaError``
    func schedulePendingAppointment(withId: UUID) async throws -> Appointment
    /// - Throws: ``NablaError``
    func cancelAppointment(withId: UUID) async throws
    /// - Throws: ``NablaError``
    func getAvailableAppointmentLocations() async throws -> Set<LocationType>
}
