import Combine
import Foundation
import NablaCore

protocol WatchAvailabilitySlotsInteractor {
    func execute(categoryId: UUID) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError>
}
