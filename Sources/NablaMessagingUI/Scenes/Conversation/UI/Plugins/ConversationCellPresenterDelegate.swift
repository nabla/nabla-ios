import Foundation
import NablaMessagingCore

protocol ConversationCellPresenterDelegate: AnyObject {
    func didUpdateState(forItemWithId id: UUID)
    func didDeleteItem(withId id: UUID)
    func didReplyToItem(withId id: UUID)
    func didTap(image: ImageFile)
    func didTap(document: DocumentFile)
    func didTapTextItem(withId id: UUID)
    func didTapMessagePreview(withId id: UUID)
}
