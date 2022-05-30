import Foundation
import NablaMessagingCore
#if canImport(NablaUtils)
    import NablaUtils
#endif

final class ConversationPresenterImpl: ConversationPresenter {
    // MARK: - Internal
    
    func start() {
        let conversationViewModel = Self.transform(conversation: conversation)
        view?.configure(withConversation: conversationViewModel)
        watchItems()
    }
    
    func didTapOnSend(text: String, medias: [Media]) {
        view?.emptyComposer()
        medias.forEach { media in
            let cancellable = client.sendMessage(media.messageInput, inConversationWithId: conversation.id, handler: { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    self.logger.warning(message: "Failed to send a media (type: \(media.type)) with error: \(error.localizedDescription)")
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
                    self.logger.warning(message: "Failed to send text with error: \(error.localizedDescription)")
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
    
    @available(iOS 14, *)
    func didTapDocumentLibraryButton() {
        view?.displayDocumentPicker()
    }
    
    func didUpdateDraftText(_ text: String) {
        guard text != draftText else {
            return
        }
        draftText = text
        localTypingDebouncer.execute { [weak self] in
            guard let self = self else { return }
            self.setTypingAction = self.client.setIsTyping(
                !text.isEmpty,
                inConversationWithId: self.conversation.id,
                handler: { _ in }
            )
        }
    }

    func didReachEndOfConversation() {
        guard canLoadMoreItems, loadMoreItemsAction == nil else { return }
        loadMoreItemsAction = itemsWatcher?.loadMore { [weak self] result in
            switch result {
            case let .failure(error):
                self?.logger.warning(message: "Failed to load more items with error: \(error.localizedDescription)")
                self?.view?.showErrorAlert(
                    viewModel: .init(
                        title: L10n.conversationLoadMoreErrorTitle,
                        message: L10n.conversationLoadMoreErrorMessage,
                        defaultAction: L10n.conversationLoadMoreErrorAlertAction
                    )
                )
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
                self.logger.error(message: "Could not delete message with error: \(error.localizedDescription)")
                self.view?.showErrorAlert(
                    viewModel: .init(
                        title: L10n.conversationDeleteMessageErrorTitle,
                        message: L10n.conversationDeleteMessageErrorMessage,
                        defaultAction: L10n.conversationDeleteMessageErrorAlertAction
                    )
                )
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

    func retry() {
        watchItems()
    }

    // MARK: Init
    
    init(
        logger: Logger,
        conversation: Conversation,
        view: ConversationViewContract,
        client: NablaMessagingClientProtocol
    ) {
        self.logger = logger
        self.view = view
        self.client = client
        self.conversation = conversation
    }
    
    // MARK: - Private
    
    private let client: NablaMessagingClientProtocol
    private var conversation: Conversation

    private let logger: Logger

    private weak var view: ConversationViewContract?
    private var conversationItems: ConversationItems?
    private var canLoadMoreItems = false
    private var draftText: String = ""
    private var itemsWatcher: PaginatedWatcher?
    private var conversationWatcher: Cancellable?
    private var sendMessageAction: Cancellable?
    private var deleteMessageAction: Cancellable?
    private var setTypingAction: Cancellable?
    private var loadMoreItemsAction: Cancellable?
    private var markAsSeenAction: Cancellable?
    private let localTypingDebouncer: Debouncer = .init(delay: 0.2, queue: .global(qos: .userInitiated))

    private var sendMediaCancellable: [Cancellable] = []
    
    private func watchItems() {
        set(state: .loading)
        
        conversationWatcher = client.watchConversation(
            conversation.id,
            handler: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .failure(error):
                    self.logger.error(message: "Failed to watch conversation with error: \(error.localizedDescription)")
                    self.set(state: .error(viewModel: .init(message: L10n.conversationLoadErrorLabel, buttonTitle: L10n.conversationListButtonRetry)))
                case let .success(conversation):
                    self.conversation = conversation
                    
                    let conversationViewModel = Self.transform(conversation: conversation)
                    self.set(conversation: conversationViewModel)
                    
                    if let conversationItems = self.conversationItems {
                        self.transformAndUpdateState(conversationItems: conversationItems, conversation: conversation)
                    }
                }
            }
        )
        
        itemsWatcher = client.watchItems(ofConversationWithId: conversation.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.logger.error(message: "Failed to watch messages with error: \(error.localizedDescription)")
                self.set(state: .error(viewModel: .init(message: L10n.conversationLoadErrorLabel, buttonTitle: L10n.conversationListButtonRetry)))
            case let .success(conversationItems):
                self.conversationItems = conversationItems
                self.transformAndUpdateState(conversationItems: conversationItems, conversation: self.conversation)
                self.markAsSeenAction = self.client.markConversationAsSeen(self.conversation.id, handler: { _ in })
                self.canLoadMoreItems = conversationItems.hasMore
            }
        }
    }

    private func set(conversation: ConversationViewModel) {
        DispatchQueue.main.async { [view] in
            view?.configure(withConversation: conversation)
        }
    }

    private func set(state: ConversationViewState) {
        DispatchQueue.main.async { [view] in
            view?.configure(withState: state)
        }
    }
    
    private static func transform(conversation: Conversation) -> ConversationViewModel {
        ConversationViewModel(
            title: conversation.title ?? conversation.inboxPreviewTitle,
            avatar: AvatarViewModel(
                url: conversation.providers.first?.provider.avatarURL,
                text: conversation.providers.first?.provider.initials
            )
        )
    }
    
    private func transformAndUpdateState(conversationItems: ConversationItems, conversation: Conversation) {
        let items = ConversationItemsTransformer.transform(conversationItems: conversationItems, conversation: conversation)
        set(state: .loaded(items: items))
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
