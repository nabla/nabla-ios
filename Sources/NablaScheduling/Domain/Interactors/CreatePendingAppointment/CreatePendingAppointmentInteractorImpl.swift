import Foundation
import NablaCore

final class CreatePendingAppointmentInteractorImpl: AuthenticatedInteractor, CreatePendingAppointmentInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(location: LocationType, categoryId: UUID, providerId: UUID, date: Date) async throws -> Appointment {
        try assertIsAuthenticated()
        return try await appointmentRepository.createPendingAppointment(
            location: location,
            categoryId: categoryId,
            providerId: providerId,
            date: date
        )
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
