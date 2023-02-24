import Foundation

protocol CreatePendingAppointmentInteractor {
    /// - Throws: ``NablaError``
    func execute(
        location: LocationType,
        categoryId: UUID,
        providerId: UUID,
        date: Date
    ) async throws -> Appointment
}
