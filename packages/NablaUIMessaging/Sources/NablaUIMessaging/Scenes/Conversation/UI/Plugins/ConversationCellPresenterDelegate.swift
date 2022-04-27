import Foundation
import NablaCore

protocol ConversationCellPresenterDelegate: AnyObject {
    func didUpdateState(forItemWithId id: UUID)
    func didDeleteItem(withId id: UUID)
    func didTapMedia(_ media: Media)
}
