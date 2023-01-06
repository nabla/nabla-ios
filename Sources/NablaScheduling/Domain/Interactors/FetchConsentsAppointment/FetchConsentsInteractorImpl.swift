import Foundation

final class FetchConsentsInteractorImpl: FetchConcentsInteractor {
    // MARK: - Internal
    
    /// - Throws: ``NablaError``
    func execute() async throws -> Consents {
        try await repository.fetchConsents()
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
