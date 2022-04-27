import Foundation
import NablaCore

final class ConversationPresenterImpl: ConversationPresenter {
    // MARK: - Internal

    func start() {
        itemsWatcher = client.watchItems(ofConversationWithId: conversation.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.set(state: .error(viewModel: .init(message: error.localizedDescription, buttonTitle: L10n.conversationListButtonRetry))) // TODO: Display error feedback
            case let .success(conversationWithItems):
                let items = self.transform(conversationWithItems: conversationWithItems)
                self.set(state: .loaded(items: items))
                self.makAsSeenAction = self.client.markConversationAsSeen(self.conversation.id)
                self.canLoadMoreItems = conversationWithItems.hasMore
            }
        }
    }

    func didTapOnSend(text: String, medias: [Media]) {
        view?.emptyComposer()
        medias.forEach {
            let cancellable = client.sendMessage($0.messageInput, inConversationWithId: conversation.id, completion: { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    print(error) // TODO: Display error
                }
            })
            sendMediaCancellable.append(cancellable)
        }
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sendMessageAction = client.sendMessage(.text(content: text), inConversationWithId: conversation.id) { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    print(error) // TODO: Display error
                }
            }
        }
    }

    func didTapCameraButton() {
        view?.displayMediaPicker(source: .camera)
    }

    func didTapPhotoLibraryButton() {
        view?.displayMediaPicker(source: .library(imageLimit: nil))
    }

    func didTapDocumentLibraryButton() {
        view?.displayDocumentPicker()
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

    func didReachEndOfConversation() {
        guard canLoadMoreItems, loadMoreItemsAction == nil else { return }
        loadMoreItemsAction = itemsWatcher?.loadMore { [weak self] result in
            switch result {
            case let .failure(error):
                print(error) // TODO: Display error
            case .success:
                break
            }
            self?.loadMoreItemsAction = nil
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

    func didTapMedia(_ media: Media) {
        switch media.type {
        case .pdf:
            view?.displayDocumentDetail(for: media)
        case .image:
            view?.displayImageDetail(for: media)
        case .video:
            // TODO: (Thibault Tourailles) - Not handled yet
            break
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
    private var canLoadMoreItems = false
    private var draftText: String = ""
    private var itemsWatcher: PaginatedWatcher?
    private var sendMessageAction: Cancellable?
    private var deleteMessageAction: Cancellable?
    private var setTypingAction: Cancellable?
    private var loadMoreItemsAction: Cancellable?
    private var makAsSeenAction: Cancellable?
    private let typingDebouncer: Debouncer = .init(delay: 0.2, queue: .global(qos: .userInitiated))

    private var sendMediaCancellable: [Cancellable] = []

    private func set(state: ConversationViewState) {
        DispatchQueue.main.async { [view] in
            view?.configure(withState: state)
        }
    }

    private func transform(conversationWithItems: ConversationWithItems) -> [ConversationViewItem] {
        var viewItems = [ConversationViewItem]()

        if conversationWithItems.hasMore {
            viewItems.append(HasMoreIndicatorViewItem())
        }

        let contentItems = conversationWithItems.items.compactMap { item -> ConversationViewItem? in
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

            if let imageMessage = item as? ImageMessageItem {
                return ImageMessageViewItem(
                    id: imageMessage.id,
                    date: imageMessage.date,
                    sender: imageMessage.sender,
                    state: imageMessage.state,
                    image: imageMessage.content
                )
            }

            if let documentMessage = item as? DocumentMessageItem {
                return DocumentMessageViewItem(
                    id: documentMessage.id,
                    date: documentMessage.date,
                    sender: documentMessage.sender,
                    state: documentMessage.state,
                    document: documentMessage.content
                )
            }
            return nil
        }
        viewItems.append(contentsOf: contentItems)

        let typingItems = conversationWithItems.typingProviders.map {
            TypingIndicatorViewItem(sender: .provider($0))
        }
        viewItems.append(contentsOf: typingItems)

        viewItems = viewItems.enumerated().map { index, element in
            guard index > 0,
                  var current = element as? ConversationViewMessageItem,
                  let previous = viewItems[index - 1] as? ConversationViewMessageItem else {
                return element
            }
            current.isContiguous = previous.sender == current.sender
            return current
        }

        return viewItems
    }
}

private extension Media {
    var messageInput: MessageInput {
        switch type {
        case .pdf:
            return .document(content: self)
        // TODO: (Thibault Tourailles) - Split video when available
        case .image, .video:
            return .image(content: self)
        }
    }
}
