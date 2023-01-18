import Combine
import Foundation
import NablaCore

protocol AvailabilitySlotRepository {
    func watchCategories() -> AnyPublisher<[Category], NablaError>
    func watchAvailabilitySlots(forCategoryWithId: UUID, location: LocationType) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError>
}
