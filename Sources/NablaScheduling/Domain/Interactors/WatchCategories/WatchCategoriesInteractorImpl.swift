import Combine
import Foundation
import NablaCore

final class WatchCategoriesInteractorImpl: AuthenticatedInteractor, WatchCategoriesInteractor {
    // MARK: - Internal
    
    func execute() -> AnyPublisher<[Category], NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [repository] in
                repository.watchCategories()
            }
    }
    
    // MARK: Init
    
    init(
        authenticator: Authenticator,
        repository: AvailabilitySlotRepository
    ) {
        self.repository = repository
        super.init(authenticator: authenticator)
    }
    
    // MARK: - Private
    
    private let repository: AvailabilitySlotRepository
}
