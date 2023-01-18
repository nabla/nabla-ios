import Foundation

// sourcery: AutoMockable
protocol ConsentsRemoteDataSource {
    /// - Throws: ``GQLError``
    func fetchConsents() async throws -> RemoteConsents
}
