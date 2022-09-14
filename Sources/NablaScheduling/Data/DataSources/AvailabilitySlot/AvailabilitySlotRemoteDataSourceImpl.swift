import Combine
import Foundation
import NablaCore

final class AvailabilitySlotRemoteDataSourceImpl: AvailabilitySlotRemoteDataSource {
    // MARK: - Internal
    
    func watchCategories() -> AnyPublisher<[RemoteCategory], GQLError> {
        gqlClient.watch(query: GQL.GetCategoriesQuery())
            .map { response -> [RemoteCategory] in
                response.appointmentCategories.categories.map(\.fragments.categoryFragment)
            }
            .eraseToAnyPublisher()
    }
    
    func watchAvailabilitySlots(forCategoryWithId categoryId: UUID) -> AnyPublisher<PaginatedList<RemoteAvailabilitySlot>, GQLError> {
        gqlClient.watch(
            query: Queries.getAvailableSlotsRootQuery(categoryId: categoryId)
        )
        .map { response -> PaginatedList<RemoteAvailabilitySlot> in
            let data = response.appointmentCategory.category.availableSlots.slots.map(\.fragments.availabilitySlotFragment)
            
            var fetchMore: (() async throws -> Void)?
            if let cursor = response.appointmentCategory.category.availableSlots.nextCursor {
                fetchMore = { [weak self] in
                    try await self?.fetchMoreAvailableSlots(forCategoryWithId: categoryId, cursor: cursor)
                }
            }
            
            return PaginatedList<RemoteAvailabilitySlot>(
                data: data,
                hasMore: response.appointmentCategory.category.availableSlots.hasMore,
                loadMore: fetchMore
            )
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: Init
    
    init(
        gqlClient: AsyncGQLClient,
        gqlStore: AsyncGQLStore
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
    }
    
    // MARK: - Private
    
    private let gqlClient: AsyncGQLClient
    private let gqlStore: AsyncGQLStore
    
    private enum Queries {
        static func getAvailableSlotsRootQuery(categoryId: UUID) -> GQL.GetAvailableSlotsQuery {
            getAvailableSlotsQuery(categoryId: categoryId, cursor: nil)
        }
        
        static func getAvailableSlotsQuery(categoryId: UUID, cursor: String?) -> GQL.GetAvailableSlotsQuery {
            GQL.GetAvailableSlotsQuery(categoryId: categoryId, page: .init(cursor: cursor, numberOfItems: 100))
        }
    }
    
    private func fetchMoreAvailableSlots(forCategoryWithId categoryId: UUID, cursor: String) async throws {
        let response = try await gqlClient.fetch(
            query: Queries.getAvailableSlotsQuery(categoryId: categoryId, cursor: cursor),
            cachePolicy: .fetchIgnoringCacheCompletely
        )
        
        try await gqlStore.updateCache(
            for: Queries.getAvailableSlotsRootQuery(categoryId: categoryId),
            onlyIfExists: true,
            body: { (cache: inout GQL.GetAvailableSlotsQuery.Data) in
                Self.append(response, to: &cache)
            }
        )
    }
    
    private static func append(_ response: GQL.GetAvailableSlotsQuery.Data, to cache: inout GQL.GetAvailableSlotsQuery.Data) {
        cache.appointmentCategory.category.availableSlots.hasMore = response.appointmentCategory.category.availableSlots.hasMore
        cache.appointmentCategory.category.availableSlots.nextCursor = response.appointmentCategory.category.availableSlots.nextCursor
        
        let makeKey: (RemoteAvailabilitySlot) -> String = { slot in
            "\(slot.startAt) - \(slot.endAt)"
        }
        let existingSlots = Set(cache.appointmentCategory.category.availableSlots.slots.map { makeKey($0.fragments.availabilitySlotFragment) })
        
        for newSlot in response.appointmentCategory.category.availableSlots.slots {
            let key = makeKey(newSlot.fragments.availabilitySlotFragment)
            guard !existingSlots.contains(key) else { continue }
            cache.appointmentCategory.category.availableSlots.slots.append(newSlot)
        }
    }
}
