import Combine
import Foundation
import NablaCore

final class AvailabilitySlotRemoteDataSourceImpl: AvailabilitySlotRemoteDataSource {
    // MARK: - Internal
    
    func watchCategories() -> AnyPublisher<[RemoteCategory], GQLError> {
        gqlClient.watch(
            query: GQL.GetCategoriesQuery(),
            policy: .fetchIgnoringCacheData
        )
        .map { response -> [RemoteCategory] in
            response.appointmentCategories.categories.map(\.fragments.categoryFragment)
        }
        .eraseToAnyPublisher()
    }
    
    func watchAvailabilitySlots(forCategoryWithId categoryId: UUID, isPhysical: Bool) -> AnyPublisher<PaginatedList<RemoteAvailabilitySlot>, GQLError> {
        gqlClient.watch(
            query: Queries.getAvailableSlotsRootQuery(isPhysical: isPhysical, categoryId: categoryId),
            policy: .fetchIgnoringCacheData
        )
        .map { response -> PaginatedList<RemoteAvailabilitySlot> in
            let availableSlots = response.appointmentCategory.category.availableSlotsV2
            let data = availableSlots.slots.map(\.fragments.availabilitySlotFragment)
            
            var fetchMore: (() async throws -> Void)?
            if let cursor = availableSlots.nextCursor {
                fetchMore = { [weak self] in
                    try await self?.fetchMoreAvailableSlots(
                        forCategoryWithId: categoryId,
                        isPhysical: isPhysical,
                        cursor: cursor
                    )
                }
            }
            
            return PaginatedList<RemoteAvailabilitySlot>(
                elements: data,
                loadMore: fetchMore
            )
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: Init
    
    init(
        gqlClient: GQLClient,
        gqlStore: GQLStore
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
    }
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    
    private enum Queries {
        static func getAvailableSlotsRootQuery(isPhysical: Bool, categoryId: UUID) -> GQL.GetAvailableSlotsQuery {
            getAvailableSlotsQuery(isPhysical: isPhysical, categoryId: categoryId, cursor: nil)
        }
        
        static func getAvailableSlotsQuery(
            isPhysical: Bool,
            categoryId: UUID,
            cursor: String?
        ) -> GQL.GetAvailableSlotsQuery {
            GQL.GetAvailableSlotsQuery(
                isPhysical: isPhysical,
                categoryId: categoryId,
                page: .init(cursor: cursor, numberOfItems: 100)
            )
        }
    }
    
    private func fetchMoreAvailableSlots(forCategoryWithId categoryId: UUID, isPhysical: Bool, cursor: String) async throws {
        let response = try await gqlClient.fetch(
            query: Queries.getAvailableSlotsQuery(isPhysical: isPhysical, categoryId: categoryId, cursor: cursor),
            policy: .fetchIgnoringCacheCompletely
        )
        
        try await gqlStore.updateCache(
            for: Queries.getAvailableSlotsRootQuery(isPhysical: isPhysical, categoryId: categoryId),
            onlyIfExists: true,
            body: { (cache: inout GQL.GetAvailableSlotsQuery.Data) in
                Self.append(response, to: &cache)
            }
        )
    }
    
    private static func append(_ response: GQL.GetAvailableSlotsQuery.Data, to cache: inout GQL.GetAvailableSlotsQuery.Data) {
        cache.appointmentCategory.category.availableSlotsV2.hasMore = response.appointmentCategory.category.availableSlotsV2.hasMore
        cache.appointmentCategory.category.availableSlotsV2.nextCursor = response.appointmentCategory.category.availableSlotsV2.nextCursor
        
        let makeKey: (RemoteAvailabilitySlot) -> String = { slot in
            "\(slot.startAt) - \(slot.endAt)"
        }
        let existingSlots = Set(cache.appointmentCategory.category.availableSlotsV2.slots.map { makeKey($0.fragments.availabilitySlotFragment) })
        
        for newSlot in response.appointmentCategory.category.availableSlotsV2.slots {
            let key = makeKey(newSlot.fragments.availabilitySlotFragment)
            guard !existingSlots.contains(key) else { continue }
            cache.appointmentCategory.category.availableSlotsV2.slots.append(newSlot)
        }
    }
}
