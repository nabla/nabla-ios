import Combine
import Foundation
import NablaCore

final class WatchAppointmentsInteractorImpl: WatchAppointmentsInteractor {
    // MARK: - Internal
    
    func execute(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError> {
        repository.watchAppointments(state: state)
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
