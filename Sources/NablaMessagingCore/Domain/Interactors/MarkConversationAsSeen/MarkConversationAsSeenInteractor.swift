import Foundation
import NablaCore

protocol MarkConversationAsSeenInteractor {
    /// - Throws: ``NablaError``
    func execute(conversationId: UUID) async throws
}
