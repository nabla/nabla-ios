import Combine
import Foundation
import NablaCore

protocol WatchAppointmentsInteractor {
    func execute(state: Appointment.State) -> AnyPublisher<PaginatedList<Appointment>, NablaError>
}
