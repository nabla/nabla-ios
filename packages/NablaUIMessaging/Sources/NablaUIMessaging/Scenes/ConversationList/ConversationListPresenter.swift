import Foundation
import NablaCore
import NablaUtils

protocol Presenter {
    func start()
}

protocol ConversationListPresenter: Presenter {
    func userDidTapActionButton()
}

class ConversationListPresenterImpl: ConversationListPresenter {
    init(view: ConversationListViewContract) {
        self.view = view
    }

    func start() {
        client.getConversations { _ in
        }
    }

    func userDidTapActionButton() {}

    weak var view: ConversationListViewContract?

    @Inject private var client: NablaClient

    private var conversationsWatcher: Any?
}
