import Combine
import Foundation
import NablaCore

final class WatchAppointmentsInteractorImpl: AuthenticatedInteractor, WatchAppointmentsInteractor {
    // MARK: - Internal
    
    func execute(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError> {
        isAuthenticated
            .map { [repository] in
                repository.watchAppointments(state: state)
            }
            .switchToLatest()
            .eraseToAnyPublisher()
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
