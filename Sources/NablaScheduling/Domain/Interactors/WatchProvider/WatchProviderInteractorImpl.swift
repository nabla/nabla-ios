import Combine
import Foundation
import NablaCore

final class WatchProviderInteractorImpl: AuthenticatedInteractor, WatchProviderInteractor {
    // MARK: - Internal

    func execute(providerId: UUID) -> AnyPublisher<Provider, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [providerRepository] in
                providerRepository.watchProvider(id: providerId)
            }
    }
    
    // MARK: Init
    
    init(
        userRepository: UserRepository,
        providerRepository: ProviderRepository
    ) {
        self.providerRepository = providerRepository
        super.init(userRepository: userRepository)
    }
    
    // MARK: - Private
    
    private let providerRepository: ProviderRepository
}
