import Combine
import Foundation
import NablaCore

final class WatchAppointmentsInteractorImpl: AuthenticatedInteractor, WatchAppointmentsInteractor {
    // MARK: - Internal
    
    func execute(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [appointmentRepository] in
                appointmentRepository.watchAppointments(state: state)
            }
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
