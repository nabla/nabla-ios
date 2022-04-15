import Foundation

protocol ConversationListPresenter: Presenter {
    func didSelectConversation(at indexPath: IndexPath)
    func didScrollToBottom()
}
