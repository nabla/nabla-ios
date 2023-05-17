import Combine
import Foundation
import NablaCore

final class WatchCategoriesInteractorImpl: AuthenticatedInteractor, WatchCategoriesInteractor {
    // MARK: - Internal
    
    func execute() -> AnyPublisher<[Category], NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [availabilitySlotRepository] in
                availabilitySlotRepository.watchCategories()
            }
    }
    
    // MARK: Init
    
    init(
        userRepository: UserRepository,
        availabilitySlotRepository: AvailabilitySlotRepository
    ) {
        self.availabilitySlotRepository = availabilitySlotRepository
        super.init(userRepository: userRepository)
    }
    
    // MARK: - Private
    
    private let availabilitySlotRepository: AvailabilitySlotRepository
}
