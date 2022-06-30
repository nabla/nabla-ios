import Foundation
import NablaCore

protocol WatchConversationInteractor {
    func execute(_ conversationId: UUID, handler: ResultHandler<Conversation, NablaError>) -> Watcher
}
