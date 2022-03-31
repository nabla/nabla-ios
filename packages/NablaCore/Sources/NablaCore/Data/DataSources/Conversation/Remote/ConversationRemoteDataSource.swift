import Foundation

protocol ConversationRemoteDataSource {
    func fetchConversations(page: Int, completion: ([RestConversation]) -> Void)
}
