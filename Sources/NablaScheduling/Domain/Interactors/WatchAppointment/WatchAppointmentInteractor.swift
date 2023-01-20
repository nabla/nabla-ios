import Combine
import Foundation
import NablaCore

protocol WatchAppointmentInteractor {
    func execute(id: UUID) -> AnyPublisher<Appointment, NablaError>
}
