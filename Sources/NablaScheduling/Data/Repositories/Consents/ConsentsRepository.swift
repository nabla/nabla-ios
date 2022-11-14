import Foundation

protocol ConsentsRepository {
    /// Throws: `NablaError`
    func fetchConsents() async throws -> Consents
}
