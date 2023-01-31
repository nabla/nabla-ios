import Combine
import Foundation
import NablaCore

protocol WatchConsentsInteractor {
    func execute(location: LocationType) -> AnyPublisher<Consents, NablaError>
}
