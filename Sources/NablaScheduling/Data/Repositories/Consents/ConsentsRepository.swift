import Foundation

protocol ConsentsRepository {
    /// - Throws: ``NablaError``
    func fetchConsents(location: LocationType) async throws -> Consents
}
