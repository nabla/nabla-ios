import Combine
import Foundation
import NablaCore

protocol WatchCategoriesInteractor {
    func execute() -> AnyPublisher<[Category], NablaError>
}
