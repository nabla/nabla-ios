import Foundation

protocol FetchConcentsInteractor {
    /// - Throws: ``NablaError``
    func execute() async throws -> Consents
}
