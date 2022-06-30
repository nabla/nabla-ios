import Foundation
import NablaCore

protocol WatchConversationsInteractor {
    func execute(handler: ResultHandler<ConversationList, NablaError>) -> PaginatedWatcher
}
