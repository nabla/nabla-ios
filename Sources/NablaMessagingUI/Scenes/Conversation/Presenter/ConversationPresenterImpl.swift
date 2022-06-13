import Foundation
import NablaMessagingCore
#if canImport(NablaUtils)
    import NablaUtils
#endif

final class ConversationPresenterImpl: ConversationPresenter {
    // MARK: - Internal

    func start() {
        if canRecordAudio {
            view?.showRecordAudioMessageButton = true
        } else {
            logger.warning(message: "Missing `NSMicrophoneUsageDescription` key in info.plist to enable audio message recording")
            view?.showRecordAudioMessageButton = false
        }
        if let conversation = conversation {
            let conversationViewModel = Self.transform(conversation: conversation)
            view?.configure(withConversation: conversationViewModel)
        }
        watchItems()
    }
    
    func didTapOnSend(text: String, medias: [Media]) {
        view?.emptyComposer()
        medias.forEach { media in
            guard let input = media.messageInput else { return }
            let cancellable = client.sendMessage(input, inConversationWithId: conversationId, handler: { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    self.logger.warning(message: "Failed to send a media", extra: ["type": type(of: media), "reason": error])
                }
            })
            sendMediaCancellable.append(cancellable)
        }
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sendMessageAction = client.sendMessage(.text(content: text), inConversationWithId: conversationId) { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    self.logger.warning(message: "Failed to send text", extra: ["reason": error])
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

    func didFinishRecordingAudioFile(_ file: AudioFile) {
        sendAudioMessageAction = client.sendMessage(.audio(content: file), inConversationWithId: conversationId) { [weak self] result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self?.logger.warning(message: "Failed to send text", extra: ["reason": error])
            }
        }
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
                inConversationWithId: self.conversationId,
                handler: { _ in }
            )
        }
    }

    func didReachEndOfConversation() {
        guard canLoadMoreItems, loadMoreItemsAction == nil else { return }
        loadMoreItemsAction = itemsWatcher?.loadMore { [weak self] result in
            switch result {
            case let .failure(error):
                self?.logger.warning(message: "Failed to load more items", extra: ["reason": error])
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
            conversationId: conversationId
        ) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.logger.warning(message: "Failed to delete message", extra: ["reason": error])
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
        case .audio:
            // ???: Can't tap audio messages
            break
        }
    }

    func didTapTextItem(withId id: UUID) {
        guard case .patient = (conversationItems?.items.first(where: { $0.id == id }) as? TextMessageItem)?.sender else {
            return
        }
        if id == focusedPatientTextItemId {
            focusedPatientTextItemId = nil
        } else {
            focusedPatientTextItemId = id
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
        conversationId = conversation.id
        self.conversation = conversation
    }
    
    init(
        logger: Logger,
        conversationId: UUID,
        view: ConversationViewContract,
        client: NablaMessagingClientProtocol
    ) {
        self.logger = logger
        self.view = view
        self.client = client
        self.conversationId = conversationId
    }
    
    // MARK: - Private
    
    private let client: NablaMessagingClientProtocol
    private let conversationId: UUID

    private let logger: Logger

    private weak var view: ConversationViewContract?
    private var conversation: Conversation?
    private var conversationItems: ConversationItems?
    private var canLoadMoreItems = false
    private var draftText: String = ""
    private var focusedPatientTextItemId: UUID? {
        didSet {
            refreshItems()
        }
    }

    private var itemsWatcher: PaginatedWatcher?
    private var conversationWatcher: Cancellable?
    private var sendMessageAction: Cancellable?
    private var sendAudioMessageAction: Cancellable?
    private var deleteMessageAction: Cancellable?
    private var setTypingAction: Cancellable?
    private var loadMoreItemsAction: Cancellable?
    private var markAsSeenAction: Cancellable?
    private let localTypingDebouncer: Debouncer = .init(delay: 0.2, queue: .global(qos: .userInitiated))

    private var sendMediaCancellable: [Cancellable] = []
    
    private var canRecordAudio: Bool {
        Bundle.main.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") as? String != nil
    }

    private func watchItems() {
        set(state: .loading)
        
        conversationWatcher = client.watchConversation(
            conversationId,
            handler: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .failure(error):
                    self.logger.warning(message: "Failed to watch conversation", extra: ["reason": error])
                    self.set(state: .error(viewModel: .init(message: L10n.conversationLoadErrorLabel, buttonTitle: L10n.conversationListButtonRetry)))
                case let .success(conversation):
                    self.conversation = conversation
                    
                    let conversationViewModel = Self.transform(conversation: conversation)
                    self.set(conversation: conversationViewModel)

                    self.refreshItems()
                }
            }
        )
        
        itemsWatcher = client.watchItems(ofConversationWithId: conversationId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.logger.warning(message: "Failed to watch messages", extra: ["reason": error])
                self.set(state: .error(viewModel: .init(message: L10n.conversationLoadErrorLabel, buttonTitle: L10n.conversationListButtonRetry)))
            case let .success(conversationItems):
                self.conversationItems = conversationItems
                self.refreshItems()
                self.markAsSeenAction = self.client.markConversationAsSeen(self.conversationId, handler: { _ in })
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
    
    private func transformAndUpdateState(conversationItems: ConversationItems, conversation: Conversation?) {
        let items = ConversationItemsTransformer.transform(
            conversationItems: conversationItems,
            providers: conversation?.providers ?? [],
            focusedTextItemId: focusedPatientTextItemId
        )
        set(state: .loaded(items: items))
    }

    private func refreshItems() {
        conversationItems.map {
            transformAndUpdateState(conversationItems: $0, conversation: conversation)
        }
    }
}

private extension Media {
    var messageInput: MessageInput? {
        switch type {
        case .pdf:
            return .document(content: self)
        // TODO: (Thibault Tourailles) - Split video when available
        case .image:
            return .image(content: self)
        case .video, .audio:
            return nil
        }
    }
}
