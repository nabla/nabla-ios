import Combine
import Foundation
import NablaCore

protocol ConsentsRepository {
    func watchConsents(location: LocationType) -> AnyPublisher<Consents, NablaError>
}
