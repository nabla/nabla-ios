import Foundation

final class FetchConsentsInteractorImpl: FetchConcentsInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute(location: LocationType) async throws -> Consents {
        try await repository.fetchConsents(location: location)
    }
    
    // MARK: Init
    
    init(
        repository: ConsentsRepository
    ) {
        self.repository = repository
    }
    
    // MARK: - Private
    
    private let repository: ConsentsRepository
}
