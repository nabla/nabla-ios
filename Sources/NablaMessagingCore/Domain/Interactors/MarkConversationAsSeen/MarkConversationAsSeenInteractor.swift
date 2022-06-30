import Foundation
import NablaCore

protocol MarkConversationAsSeenInteractor {
    func execute(
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
