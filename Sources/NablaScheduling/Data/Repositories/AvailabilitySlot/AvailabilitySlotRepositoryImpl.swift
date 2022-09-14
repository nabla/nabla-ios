import Combine
import Foundation
import NablaCore

final class AvailabilitySlotRepositoryImpl: AvailabilitySlotRepository {
    // MARK: - Internal
    
    func watchCategories() -> AnyPublisher<[Category], NablaError> {
        remoteDataSource.watchCategories()
            .map { remoteCategories in
                remoteCategories.map(RemoteCategoryTransformer.transform(_:))
            }
            .mapError(GQLErrorTransformer.transform)
            .eraseToAnyPublisher()
    }
    
    func watchAvailabilitySlots(forCategoryWithId categoryId: UUID) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError> {
        remoteDataSource.watchAvailabilitySlots(forCategoryWithId: categoryId)
            .map { remoteList -> PaginatedList<AvailabilitySlot> in
                PaginatedList(
                    data: remoteList.data.map(RemoteAvailabilitySlotsTransformer.transform),
                    hasMore: remoteList.hasMore,
                    loadMore: remoteList.loadMore
                )
            }
            .mapError(GQLErrorTransformer.transform)
            .eraseToAnyPublisher()
    }
    
    // MARK: Init
    
    init(
        remoteDataSource: AvailabilitySlotRemoteDataSource
    ) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Private
    
    private let remoteDataSource: AvailabilitySlotRemoteDataSource
}
