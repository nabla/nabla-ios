import Foundation
import NablaCore

final class CancelAppointmentInteractorImpl: AuthenticatedInteractor, CancelAppointmentInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(appointmentId: UUID) async throws {
        try assertIsAuthenticated()
        return try await appointmentRepository.cancelAppointment(withId: appointmentId)
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
