import Combine
import Foundation
import NablaCore

final class WatchConsentsInteractorImpl: WatchConsentsInteractor {
    // MARK: - Internal

    func execute(location: LocationType) -> AnyPublisher<Consents, NablaCore.NablaError> {
        repository.watchConsents(location: location)
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
