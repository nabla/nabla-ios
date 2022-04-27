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
                self.client.markConversationAsSeen(self.conversation.id)
            }
        }
    }

    func didTapOnSend(text: String) {
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

    func didUpdateDraftText(_ text: String) {
        guard text != draftText else {
            return
        }
        draftText = text
        typingDebouncer.execute { [weak self] in
            guard let self = self else { return }
            self.setTypingAction = self.client.setIsTyping(
                !text.isEmpty,
                inConversationWithId: self.conversation.id
            )
        }
    }

    func didTapDeleteMessageButton(withId messageId: UUID) {
        deleteMessageAction = client.deleteMessage(
            withId: messageId,
            conversationId: conversation.id
        ) { result in
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
    private var draftText: String = ""
    private var sendMessageAction: Cancellable?
    private var deleteMessageAction: Cancellable?
    private var watchItemsAction: Cancellable?
    private var setTypingAction: Cancellable?
    private let typingDebouncer: Debouncer = .init(delay: 0.2, queue: .global(qos: .userInitiated))

    private func set(state: ConversationViewState) {
        DispatchQueue.main.async { [view] in
            view?.configure(withState: state)
        }
    }

    private func transform(conversationWithItems: ConversationWithItems) -> [ConversationViewItem] {
        var result = conversationWithItems.items.compactMap { item -> ConversationViewItem? in
            if let textMessage = item as? TextMessageItem {
                return TextMessageViewItem(
                    id: textMessage.id,
                    date: textMessage.date,
                    sender: textMessage.sender,
                    state: textMessage.state,
                    text: textMessage.content
                )
            } else if let deletedMessage = item as? DeleteMessageItem {
                return DeletedMessageViewItem(
                    id: deletedMessage.id,
                    date: deletedMessage.date,
                    sender: deletedMessage.sender,
                    state: deletedMessage.state
                )
            }
            return nil
        }

        conversationWithItems.typingProviders.forEach { typingProvider in
            result.append(TypingIndicatorViewItem(sender: .provider(typingProvider)))
        }

        return result
    }
}
