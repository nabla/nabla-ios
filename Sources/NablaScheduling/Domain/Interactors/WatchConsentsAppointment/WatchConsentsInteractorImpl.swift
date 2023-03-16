import Combine
import Foundation
import NablaCore

final class WatchConsentsInteractorImpl: AuthenticatedInteractor, WatchConsentsInteractor {
    // MARK: - Internal

    func execute(location: LocationType) -> AnyPublisher<Consents, NablaCore.NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [repository] in
                repository.watchConsents(location: location)
            }
    }
    
    // MARK: Init
    
    init(
        authenticator: Authenticator,
        repository: ConsentsRepository
    ) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }
    
    // MARK: - Private
    
    private let repository: ConsentsRepository
}
