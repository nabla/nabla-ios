import Combine
import Foundation
import NablaCore

final class WatchConsentsInteractorImpl: AuthenticatedInteractor, WatchConsentsInteractor {
    // MARK: - Internal

    func execute(location: LocationType) -> AnyPublisher<Consents, NablaCore.NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [consentsRepository] in
                consentsRepository.watchConsents(location: location)
            }
    }
    
    // MARK: Init
    
    init(
        userRepository: UserRepository,
        consentsRepository: ConsentsRepository
    ) {
        self.consentsRepository = consentsRepository
        super.init(userRepository: userRepository)
    }
    
    // MARK: - Private
    
    private let consentsRepository: ConsentsRepository
}
