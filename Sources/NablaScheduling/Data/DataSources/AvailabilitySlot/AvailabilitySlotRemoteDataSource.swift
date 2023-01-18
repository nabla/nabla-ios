import Combine
import Foundation
import NablaCore

struct PaginatedList<T> {
    let data: [T]
    let hasMore: Bool
    let loadMore: (() async throws -> Void)?
}

protocol AvailabilitySlotRemoteDataSource {
    func watchCategories() -> AnyPublisher<[RemoteCategory], GQLError>
    func watchAvailabilitySlots(forCategoryWithId: UUID, isPhysical: Bool) -> AnyPublisher<PaginatedList<RemoteAvailabilitySlot>, GQLError>
}
