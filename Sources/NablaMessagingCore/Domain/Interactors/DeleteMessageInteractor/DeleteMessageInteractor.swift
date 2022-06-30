import Foundation
import NablaCore

protocol DeleteMessageInteractor {
    func execute(
        messageId: UUID,
        conversationId: UUID,
        handler: ResultHandler<Void, NablaError>
    ) -> Cancellable
}
