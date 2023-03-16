import Foundation
import NablaCore

final class CancelAppointmentInteractorImpl: AuthenticatedInteractor, CancelAppointmentInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(appointmentId: UUID) async throws {
        try assertIsAuthenticated()
        return try await repository.cancelAppointment(withId: appointmentId)
    }
    
    // MARK: Init
    
    init(
        authenticator: Authenticator,
        repository: AppointmentRepository
    ) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }
    
    // MARK: - Private
    
    private let repository: AppointmentRepository
}
