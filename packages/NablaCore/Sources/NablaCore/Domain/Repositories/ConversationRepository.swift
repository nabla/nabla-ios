import Foundation

protocol ConversationRepository {
    func getList(_ completion: ([Int]) -> Void)
}
