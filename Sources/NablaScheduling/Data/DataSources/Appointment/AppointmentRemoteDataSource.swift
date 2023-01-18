import Combine
import Foundation
import NablaCore

protocol AppointmentRemoteDataSource {
    func watchAppointments(state: RemoteAppointment.State.Enum) -> AnyPublisher<PaginatedList<RemoteAppointment>, GQLError>
    func subscribeToAppointmentsEvents() -> AnyPublisher<RemoteAppointmentsEvent, Never>
    /// - Throws: ``GQLError``
    func scheduleAppointment(
        isPhysical: Bool,
        categoryId: UUID,
        providerId: UUID,
        date: Date
    ) async throws -> RemoteAppointment
    /// - Throws: ``GQLError``
    func cancelAppointment(withId: UUID) async throws
    /// - Throws: ``GQLError``
    func getAvailableLocations() async throws -> RemoteAvailableLocations
}
