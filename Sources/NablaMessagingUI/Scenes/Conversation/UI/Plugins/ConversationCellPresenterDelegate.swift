import Foundation
import NablaMessagingCore

protocol ConversationCellPresenterDelegate: AnyObject {
    func didUpdateState(forItemWithId id: UUID)
    func didDeleteItem(withId id: UUID)
    func didTapMedia(_ media: Media)
    func didTapTextItem(withId id: UUID)
}
