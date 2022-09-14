import Combine
import Foundation
import NablaCore

protocol ProviderRepository {
    func watchProvider(id: UUID) -> AnyPublisher<Provider, NablaError>
}
