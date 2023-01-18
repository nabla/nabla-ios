import Foundation

protocol GetAvailableLocationsInteractor {
    /// - Throws: ``NablaError``
    func execute() async throws -> Set<LocationType>
}
