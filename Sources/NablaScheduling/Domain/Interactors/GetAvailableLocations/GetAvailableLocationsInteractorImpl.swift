import Foundation
import NablaCore

final class GetAvailableLocationsInteractorImpl: AuthenticatedInteractor, GetAvailableLocationsInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute() async throws -> Set<LocationType> {
        try assertIsAuthenticated()
        return try await appointmentRepository.getAvailableAppointmentLocations()
    }
    
    // MARK: Init
    
    init(
        userRepository: UserRepository,
        appointmentRepository: AppointmentRepository
    ) {
        self.appointmentRepository = appointmentRepository
        super.init(userRepository: userRepository)
    }
    
    // MARK: - Private
    
    private let appointmentRepository: AppointmentRepository
}
