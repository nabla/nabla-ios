import Combine
import Foundation
import NablaCore

protocol AvailabilitySlotRemoteDataSource {
    func watchCategories() -> AnyPublisher<[RemoteCategory], GQLError>
    func watchAvailabilitySlots(forCategoryWithId: UUID, isPhysical: Bool) -> AnyPublisher<PaginatedList<RemoteAvailabilitySlot>, GQLError>
}
