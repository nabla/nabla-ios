import Foundation
import NablaCore

protocol SetIsTypingInteractor {
    /// - Throws: ``NablaError``
    func execute(isTyping: Bool, conversationId: UUID) async throws
}
