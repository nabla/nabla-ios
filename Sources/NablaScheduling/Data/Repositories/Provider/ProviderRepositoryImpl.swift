import Combine
import Foundation
import NablaCore

final class ProviderRepositoryImpl: ProviderRepository {
    // MARK: - Internal

    func watchProvider(id: UUID) -> AnyPublisher<Provider, NablaError> {
        remoteDataSource.watchProvider(id: id)
            .map(RemoteProviderTransformer.transform)
            .mapError(GQLErrorTransformer.transform)
            .eraseToAnyPublisher()
    }

    // MARK: Init

    init(
        remoteDataSource: ProviderRemoteDataSource
    ) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - Private

    private let remoteDataSource: ProviderRemoteDataSource
}
