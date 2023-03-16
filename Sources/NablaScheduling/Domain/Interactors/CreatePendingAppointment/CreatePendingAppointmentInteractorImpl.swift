import Foundation
import NablaCore

final class CreatePendingAppointmentInteractorImpl: AuthenticatedInteractor, CreatePendingAppointmentInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(location: LocationType, categoryId: UUID, providerId: UUID, date: Date) async throws -> Appointment {
        try assertIsAuthenticated()
        return try await repository.createPendingAppointment(
            location: location,
            categoryId: categoryId,
            providerId: providerId,
            date: date
        )
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
