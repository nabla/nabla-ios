import Foundation
import NablaCore

protocol CreateConversationInteractor {
    /// - Throws: ``NablaError``
    func execute(
        message: MessageInput,
        title: String?,
        providerIds: [UUID]?
    ) async throws -> Conversation
}
