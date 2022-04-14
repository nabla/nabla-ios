import Foundation

protocol ConversationPresenter: Presenter {
    func send(text: String)
}
