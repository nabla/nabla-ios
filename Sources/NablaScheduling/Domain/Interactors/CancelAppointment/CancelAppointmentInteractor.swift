import Foundation

protocol CancelAppointmentInteractor {
    /// Throws `NablaError`
    func execute(appointmentId: UUID) async throws
}
