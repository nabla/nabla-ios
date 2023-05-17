import Combine
import Foundation
import NablaCore

final class WatchAppointmentInteractorImpl: AuthenticatedInteractor, WatchAppointmentInteractor {
    // MARK: - Internal
    
    func execute(id: UUID) -> AnyPublisher<Appointment, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [appointmentRepository] in
                appointmentRepository.watchAppointment(withId: id)
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
