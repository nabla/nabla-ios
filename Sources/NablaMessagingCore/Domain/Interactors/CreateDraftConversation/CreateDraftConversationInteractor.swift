import Foundation
import NablaCore

protocol CreateDraftConversationInteractor {
    func execute(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation
}
