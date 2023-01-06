import Combine
import Foundation
import NablaCore

protocol WatchConversationInteractor {
    func execute(_ conversationId: UUID) -> AnyPublisher<Conversation, NablaError>
}
