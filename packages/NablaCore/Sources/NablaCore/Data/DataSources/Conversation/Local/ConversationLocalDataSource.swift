import Foundation

protocol ConversationLocalDataSource {
    func watchList(_ update: ([Int]) -> Void)
    func insert(conversation: LocalConversation, completion: () -> Void)
}
