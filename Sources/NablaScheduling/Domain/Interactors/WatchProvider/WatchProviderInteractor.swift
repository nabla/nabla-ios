import Combine
import Foundation
import NablaCore

protocol WatchProviderInteractor {
    func execute(providerId: UUID) -> AnyPublisher<Provider, NablaError>
}
