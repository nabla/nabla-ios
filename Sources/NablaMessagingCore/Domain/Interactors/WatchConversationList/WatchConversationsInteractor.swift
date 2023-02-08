import Combine
import Foundation
import NablaCore

protocol WatchConversationsInteractor {
    func execute() -> AnyPublisher<Response<PaginatedList<Conversation>>, NablaError>
}
