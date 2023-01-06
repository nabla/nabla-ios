import Foundation
import NablaCore

final class CancelAppointmentInteractorImpl: CancelAppointmentInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(appointmentId: UUID) async throws {
        try await repository.cancelAppointment(withId: appointmentId)
    }
    
    // MARK: Init
    
    init(
        repository: AppointmentRepository
    ) {
        self.repository = repository
    }
    
    // MARK: - Private
    
    private let repository: AppointmentRepository
}
