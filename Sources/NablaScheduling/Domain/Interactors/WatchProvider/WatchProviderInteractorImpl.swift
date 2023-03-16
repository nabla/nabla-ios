import Combine
import Foundation
import NablaCore

final class WatchProviderInteractorImpl: AuthenticatedInteractor, WatchProviderInteractor {
    // MARK: - Internal

    func execute(providerId: UUID) -> AnyPublisher<Provider, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [repository] in
                repository.watchProvider(id: providerId)
            }
    }
    
    // MARK: Init
    
    init(
        authenticator: Authenticator,
        repository: ProviderRepository
    ) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }
    
    // MARK: - Private
    
    private let repository: ProviderRepository
}
