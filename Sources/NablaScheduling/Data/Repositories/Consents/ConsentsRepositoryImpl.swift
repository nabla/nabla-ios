import Combine
import Foundation
import NablaCore

final class ConsentsRepositoryImpl: ConsentsRepository {
    func watchConsents(location: LocationType) -> AnyPublisher<Consents, NablaError> {
        remoteDataSource.watchConsents()
            .map { remoteConsents in
                RemoteConsentsTransformer.transform(remoteConsents, location: location)
            }
            .mapError(GQLErrorTransformer.transform)
            .eraseToAnyPublisher()
    }

    // MARK: Init

    init(
        remoteDataSource: ConsentsRemoteDataSource
    ) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - Private

    private let remoteDataSource: ConsentsRemoteDataSource
}
