import Combine
import Foundation

final class SchedulingPendingAppointmentInteractorImpl: SchedulingPendingAppointmentInteractor {
    // MARK: - Internal
    
    func execute(appointmentId: UUID) async throws -> Appointment {
        try await repository.schedulePendingAppointment(withId: appointmentId)
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
