import Combine
import Foundation
import NablaCore

final class WatchAvailabilitySlotsInteractorImpl: WatchAvailabilitySlotsInteractor {
    // MARK: - Internal
    
    func execute(categoryId: UUID, location: LocationType) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError> {
        repository.watchAvailabilitySlots(forCategoryWithId: categoryId, location: location)
    }
    
    // MARK: Init
    
    init(
        repository: AvailabilitySlotRepository
    ) {
        self.repository = repository
    }
    
    // MARK: - Private
    
    private let repository: AvailabilitySlotRepository
}
