import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ProviderRepository {
    func watchProvider(id: UUID) -> AnyPublisher<Provider, NablaError>
}
