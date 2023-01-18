import Foundation
import NablaCore

final class ConsentsRepositoryImpl: ConsentsRepository {
    // MARK: - Internal

    /// - Throws: ``NablaError``
    func fetchConsents(location: LocationType) async throws -> Consents {
        do {
            let remoteConsents = try await remoteDataSource.fetchConsents()
            return RemoteConsentsTransformer.transform(remoteConsents, location: location)
        } catch let gqlError as GQLError {
            throw GQLErrorTransformer.transform(gqlError: gqlError)
        } catch {
            throw InternalError(underlyingError: error)
        }
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
