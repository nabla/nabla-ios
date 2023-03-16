import Foundation
import NablaCore

final class GetAvailableLocationsInteractorImpl: AuthenticatedInteractor, GetAvailableLocationsInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute() async throws -> Set<LocationType> {
        try assertIsAuthenticated()
        return try await repository.getAvailableAppointmentLocations()
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
