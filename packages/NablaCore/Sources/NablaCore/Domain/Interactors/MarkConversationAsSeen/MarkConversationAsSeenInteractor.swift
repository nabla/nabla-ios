import Foundation

protocol MarkConversationAsSeenInteractor {
    func execute(conversationId: UUID) -> Cancellable
}
