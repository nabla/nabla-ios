import Foundation
import NablaCore

final class ConversationPresenterImpl: ConversationPresenter {
    // MARK: - Internal

    func start() {
        watchItemsAction = client.watchItems(ofConversationWithId: conversation.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.set(state: .error(viewModel: .init(message: error.localizedDescription, buttonTitle: L10n.conversationListButtonRetry))) // TODO: Display error feedback
            case let .success(conversationWithItems):
                let items = self.transform(conversationWithItems: conversationWithItems)
                self.set(state: .loaded(items: items))
            }
        }
    }

    func send(text: String) {
        view?.emptyComposer()
        sendMessageAction = client.sendMessage(.text(content: text), inConversationWithId: conversation.id) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                print(error) // TODO: Display error
            }
        }
    }
    
    // MARK: Init

    init(
        conversation: Conversation,
        view: ConversationViewContract,
        client: NablaClient
    ) {
        self.view = view
        self.client = client
        self.conversation = conversation
    }

    // MARK: - Private

    private let client: NablaClient
    private let conversation: Conversation
    
    private weak var view: ConversationViewContract?
    
    private var sendMessageAction: Cancellable?
    private var watchItemsAction: Cancellable?
    
    private func set(state: ConversationViewState) {
        DispatchQueue.main.async { [view] in
            view?.configure(withState: state)
        }
    }
    
    private func transform(conversationWithItems: ConversationItems) -> [ConversationViewItem] {
        conversationWithItems.items.compactMap { item -> ConversationViewItem? in
            if let textMessage = item as? TextMessageItem {
                return TextMessageViewItem(
                    id: textMessage.id,
                    date: textMessage.date,
                    sender: textMessage.sender,
                    state: textMessage.state,
                    text: textMessage.content
                )
            }
            return nil
        }
    }
}
