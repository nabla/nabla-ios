import Combine
import Foundation
import NablaCore

final class SchedulePendingAppointmentInteractorImpl: AuthenticatedInteractor, SchedulePendingAppointmentInteractor {
    // MARK: - Internal
    
    func execute(appointmentId: UUID) async throws -> Appointment {
        try assertIsAuthenticated()
        return try await appointmentRepository.schedulePendingAppointment(withId: appointmentId)
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
