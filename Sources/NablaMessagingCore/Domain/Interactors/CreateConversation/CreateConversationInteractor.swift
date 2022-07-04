import Foundation
import NablaCore

protocol CreateConversationInteractor {
    func execute(
        title: String?,
        providerIds: [UUID]?,
        handler: ResultHandler<Conversation, NablaError>
    ) -> Cancellable
}
