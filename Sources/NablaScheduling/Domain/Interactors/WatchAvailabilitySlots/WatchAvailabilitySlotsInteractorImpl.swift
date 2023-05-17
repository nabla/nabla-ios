import Combine
import Foundation
import NablaCore

final class WatchAvailabilitySlotsInteractorImpl: AuthenticatedInteractor, WatchAvailabilitySlotsInteractor {
    // MARK: - Internal
    
    func execute(categoryId: UUID, location: LocationType) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [availabilitySlotRepository] in
                availabilitySlotRepository.watchAvailabilitySlots(forCategoryWithId: categoryId, location: location)
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
