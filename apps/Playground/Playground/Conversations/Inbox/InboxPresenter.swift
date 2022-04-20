import Foundation
import NablaCore

protocol InboxPresenterDelegate: AnyObject {
    func inboxPresenter(_ presenter: InboxPresenter, didCreate conversation: Conversation)
    func inboxPresenter(_ presenter: InboxPresenter, didSelect conversation: Conversation)
}

protocol InboxViewContract: AnyObject {
    func set(loading: Bool)
    func display(error: String)
}

class InboxPresenter {
    // MARK: - Internal
    
    func userDidTapCreateConversation() {
        createConversation()
    }
    
    func userDidSelectConversation(_ conversation: Conversation) {
        delegate?.inboxPresenter(self, didSelect: conversation)
    }
    
    init(
        view: InboxViewContract,
        delegate: InboxPresenterDelegate
    ) {
        self.view = view
        self.delegate = delegate
    }
    
    // MARK: - Private
    
    private weak var view: InboxViewContract?
    private weak var delegate: InboxPresenterDelegate?
    
    private var createConversationAction: Cancellable?
    
    private func createConversation() {
        guard createConversationAction == nil else { return }
        
        view?.set(loading: true)
        createConversationAction = NablaClient.shared.createConversation { [weak self] result in
            guard let self = self else { return }
            self.view?.set(loading: false)
            self.createConversationAction = nil
            switch result {
            case let .failure(error):
                self.view?.display(error: error.localizedDescription)
            case let .success(conversation):
                self.delegate?.inboxPresenter(self, didCreate: conversation)
            }
        }
    }
}
