import Foundation
import NablaCore

protocol SendMessageInteractor {
    /// - Throws: ``NablaError``
    func execute(
        message: MessageInput,
        replyToMessageId: UUID?,
        conversationId: UUID
    ) async throws
}
