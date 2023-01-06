import Combine
import Foundation
import NablaCore

protocol WatchConversationsInteractor {
    func execute() -> AnyPublisher<PaginatedList<Conversation>, NablaError>
}
