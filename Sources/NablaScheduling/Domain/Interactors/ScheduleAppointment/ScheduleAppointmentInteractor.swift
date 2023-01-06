import Foundation

protocol ScheduleAppointmentInteractor {
    /// - Throws: ``NablaError``
    func execute(categoryId: UUID, providerId: UUID, date: Date) async throws -> Appointment
}
