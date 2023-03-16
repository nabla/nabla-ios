import Combine
import Foundation
import NablaCore

enum AppointmentStateFilter {
    case scheduled
    case finalized
}

protocol WatchAppointmentsInteractor {
    func execute(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError>
}
