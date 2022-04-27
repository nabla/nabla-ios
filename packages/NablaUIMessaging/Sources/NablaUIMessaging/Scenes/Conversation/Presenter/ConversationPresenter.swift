import Foundation
import NablaCore

protocol ConversationPresenter: Presenter {
    func didTapOnSend(text: String, medias: [Media])
    func didUpdateDraftText(_ text: String)
    func didTapDeleteMessageButton(withId messageId: UUID)
    func didTapMedia(_ media: Media)
    func didTapCameraButton()
    func didTapPhotoLibraryButton()
    func didTapDocumentLibraryButton()
    func didReachEndOfConversation()
}
