import Combine
import Foundation
import NablaCore

final class WatchAppointmentsInteractorImpl: WatchAppointmentsInteractor {
    // MARK: - Internal
    
    func execute(state: Appointment.State) -> AnyPublisher<PaginatedList<Appointment>, NablaError> {
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
