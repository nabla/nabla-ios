import Foundation
import NablaCore

protocol StartConversationInteractor {
    func execute(
        title: String?,
        providerIds: [UUID]?
    ) -> Conversation
}
