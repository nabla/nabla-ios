import Foundation
import NablaCore

protocol ConversationPresenter: Presenter {
    func didTapOnSend(text: String, medias: [Media])
    func didUpdateDraftText(_ text: String)
    func didRequestTapAddMediaButton()
    func didTapDeleteMessageButton(withId messageId: UUID)
}
