import Combine
import Foundation
import NablaCore

final class WatchAppointmentInteractorImpl: AuthenticatedInteractor, WatchAppointmentInteractor {
    // MARK: - Internal
    
    func execute(id: UUID) -> AnyPublisher<Appointment, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [repository] in
                repository.watchAppointment(withId: id)
            }
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
