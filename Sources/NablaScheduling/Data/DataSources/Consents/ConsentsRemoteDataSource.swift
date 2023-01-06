import Foundation

protocol ConsentsRemoteDataSource {
    /// - Throws: ``GQLError``
    func fetchConsents() async throws -> RemoteConsents
}
