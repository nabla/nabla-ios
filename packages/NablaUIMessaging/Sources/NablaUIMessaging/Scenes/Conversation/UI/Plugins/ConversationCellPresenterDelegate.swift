import Foundation

protocol ConversationCellPresenterDelegate: AnyObject {
    func didUpdateState(forItemWithId id: UUID)
}
