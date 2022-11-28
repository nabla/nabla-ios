import Foundation
import NablaCore

protocol DeleteMessageInteractor {
    /// - Throws: ``NablaError``
    func execute(messageId: UUID, conversationId: UUID) async throws
}
