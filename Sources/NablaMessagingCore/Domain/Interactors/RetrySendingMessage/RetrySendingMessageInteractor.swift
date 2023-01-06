import Foundation
import NablaCore

protocol RetrySendingMessageInteractor {
    /// - Throws: ``NablaError``
    func execute(
        itemId: UUID,
        conversationId: UUID
    ) async throws
}
