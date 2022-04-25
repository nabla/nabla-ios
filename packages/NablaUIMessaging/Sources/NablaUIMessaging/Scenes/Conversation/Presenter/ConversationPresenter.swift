import Foundation

protocol ConversationPresenter: Presenter {
    func didTapOnSend(text: String)
    func didUpdateDraftText(_ text: String)
}
