import Combine
import Foundation
import NablaCore

final class WatchAppointmentInteractorImpl: WatchAppointmentInteractor {
    // MARK: - Internal
    
    func execute(id: UUID) -> AnyPublisher<Appointment, NablaError> {
        repository.watchAppointment(withId: id)
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
