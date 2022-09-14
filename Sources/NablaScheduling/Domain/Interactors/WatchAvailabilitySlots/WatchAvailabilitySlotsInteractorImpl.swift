import Combine
import Foundation
import NablaCore

final class WatchAvailabilitySlotsInteractorImpl: WatchAvailabilitySlotsInteractor {
    // MARK: - Internal
    
    func execute(categoryId: UUID) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError> {
        repository.watchAvailabilitySlots(forCategoryWithId: categoryId)
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
