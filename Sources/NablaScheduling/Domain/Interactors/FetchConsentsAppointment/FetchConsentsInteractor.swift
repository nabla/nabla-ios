import Foundation

protocol FetchConcentsInteractor {
    /// - Throws: ``NablaError``
    func execute(location: LocationType) async throws -> Consents
}
