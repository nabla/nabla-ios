import Combine
import Foundation
import NablaCore

final class WatchProviderInteractorImpl: WatchProviderInteractor {
    // MARK: - Internal

    func execute(providerId: UUID) -> AnyPublisher<Provider, NablaError> {
        repository.watchProvider(id: providerId)
    }
    
    // MARK: Init
    
    init(
        repository: ProviderRepository
    ) {
        self.repository = repository
    }
    
    // MARK: - Private
    
    private let repository: ProviderRepository
}
