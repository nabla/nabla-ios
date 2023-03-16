import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConsentsRepository {
    func watchConsents(location: LocationType) -> AnyPublisher<Consents, NablaError>
}
