import Foundation
import NablaCore

final class ConversationPresenterImpl: ConversationPresenter {
    private var items = [ConversationViewItem]()

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

    // MARK: - Internal

    func start() {
        view?.configure(withState: .loaded(items: items))
    }

    func send(text: String) {
        items.append(.init(content: TextMessageItemContent(text: text)))
        view?.configure(withState: .loaded(items: items))
        view?.emptyComposer()
        sendMessage = client.sendMessage(.text(content: text), inConversationWithId: conversation.id) { result in
            switch result {
            case .success:
                self.items.append(.init(content: TextMessageItemContent(text: "sent")))
                self.view?.configure(withState: .loaded(items: self.items))
            case let .failure(error):
                self.items.append(.init(content: TextMessageItemContent(text: error.localizedDescription)))
                self.view?.configure(withState: .loaded(items: self.items))
            }
        }
    }

    // MARK: - Private

    private weak var view: ConversationViewContract?

    private let client: NablaClient
    private let conversation: Conversation
    private var sendMessage: Cancellable?
}
