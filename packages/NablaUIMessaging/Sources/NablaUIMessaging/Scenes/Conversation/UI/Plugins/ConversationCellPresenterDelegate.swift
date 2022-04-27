import Foundation

protocol ConversationCellPresenterDelegate: AnyObject {
    func didUpdateState(forItemWithId id: UUID)
    func didDeleteItem(withId id: UUID)
}
