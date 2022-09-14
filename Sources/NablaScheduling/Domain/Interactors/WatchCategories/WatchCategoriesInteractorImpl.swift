import Combine
import Foundation
import NablaCore

final class WatchCategoriesInteractorImpl: WatchCategoriesInteractor {
    // MARK: - Internal
    
    func execute() -> AnyPublisher<[Category], NablaError> {
        repository.watchCategories()
    }
    
    // MARK: Init
    
    init(
        repository: AvailabilitySlotRepository
    ) {
        self.repository = repository
    }
    
    // MARK: - Private
    
    private let repository: AvailabilitySlotRepository
}
