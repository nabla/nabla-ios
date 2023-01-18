import Foundation
import NablaCore

final class GetAvailableLocationsInteractorImpl: GetAvailableLocationsInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute() async throws -> Set<LocationType> {
        try await repository.getAvailableAppointmentLocations()
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
