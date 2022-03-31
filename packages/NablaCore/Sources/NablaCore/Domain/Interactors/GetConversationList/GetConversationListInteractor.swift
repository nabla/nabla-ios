import Foundation

public protocol GetConversationListInteractor {
    func execute(conversationUuid: UUID)
}
