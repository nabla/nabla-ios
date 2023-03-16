import Combine
import Foundation
import NablaCore

final class SchedulePendingAppointmentInteractorImpl: AuthenticatedInteractor, SchedulePendingAppointmentInteractor {
    // MARK: - Internal
    
    func execute(appointmentId: UUID) async throws -> Appointment {
        try assertIsAuthenticated()
        return try await repository.schedulePendingAppointment(withId: appointmentId)
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
