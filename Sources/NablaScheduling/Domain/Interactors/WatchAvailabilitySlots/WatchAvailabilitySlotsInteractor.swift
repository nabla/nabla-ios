import Combine
import Foundation
import NablaCore

protocol WatchAvailabilitySlotsInteractor {
    func execute(categoryId: UUID, location: LocationType) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError>
}
