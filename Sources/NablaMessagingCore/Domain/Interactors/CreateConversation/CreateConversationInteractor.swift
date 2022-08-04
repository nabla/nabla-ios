import Foundation
import NablaCore

protocol CreateConversationInteractor {
    func execute(
        title: String?,
        providerIds: [UUID]?,
        initialMessage: MessageInput?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable
}
