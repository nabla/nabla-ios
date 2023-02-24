import Combine
import Foundation
import NablaCore

enum AppointmentStateFilter {
    case upcoming
    case finalized
}

protocol WatchAppointmentsInteractor {
    func execute(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError>
}
