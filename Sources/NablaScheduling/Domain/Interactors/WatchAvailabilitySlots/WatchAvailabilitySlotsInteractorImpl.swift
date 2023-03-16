import Combine
import Foundation
import NablaCore

final class WatchAvailabilitySlotsInteractorImpl: AuthenticatedInteractor, WatchAvailabilitySlotsInteractor {
    // MARK: - Internal
    
    func execute(categoryId: UUID, location: LocationType) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError> {
        isAuthenticated
            .nabla.switchToLatest { [repository] in
                repository.watchAvailabilitySlots(forCategoryWithId: categoryId, location: location)
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
