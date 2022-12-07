import Foundation
import NablaCore

protocol CreateConversationInteractor {
    func execute(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> NablaCancellable
}
