import Combine
import Foundation
import NablaCore

final class WatchCategoriesInteractorImpl: AuthenticatedInteractor, WatchCategoriesInteractor {
    // MARK: - Internal
    
    func execute() -> AnyPublisher<[Category], NablaError> {
        isAuthenticated
            .map { [repository] in
                repository.watchCategories()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
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
