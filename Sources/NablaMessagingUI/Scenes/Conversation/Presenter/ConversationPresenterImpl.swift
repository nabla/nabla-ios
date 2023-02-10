import Combine
import Foundation
import NablaCore
import NablaMessagingCore

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
        observeIsTyping()
    }
    
    func didTapOnSend(text: String, medias: [Media], replyingToMessageUUID replyToUUID: UUID?) {
        view?.emptyComposer()
        didRecentlySendNewMessage = true
        
        medias.forEach { media in
            guard let input = media.messageInput else { return }
            Task(priority: .userInitiated) {
                do {
                    try await client.sendMessage(input, inConversationWithId: conversationId)
                } catch {
                    logger.warning(message: "Failed to send a media", error: error, extra: ["type": type(of: media)])
                }
            }
        }
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        Task(priority: .userInitiated) {
            do {
                try await client.sendMessage(
                    .text(content: text),
                    replyingToMessageWithId: replyToUUID,
                    inConversationWithId: conversationId
                )
            } catch {
                logger.warning(message: "Failed to send text", error: error)
            }
        }
    }
    
    func didTapCameraButton() {
        view?.displayMediaPicker(source: .camera)
    }
    
    func didTapPhotoLibraryButton() {
        view?.displayMediaPicker(source: .library(imageLimit: nil))
    }

    func didFinishRecordingAudioFile(_ file: AudioFile, replyingToMessageUUID: UUID?) {
        Task(priority: .userInitiated) {
            do {
                try await client.sendMessage(
                    .audio(content: file),
                    replyingToMessageWithId: replyingToMessageUUID,
                    inConversationWithId: conversationId
                )
            } catch {
                logger.warning(message: "Failed to send text", error: error)
            }
        }
    }

    func didReplyToMessage(withId id: UUID) {
        guard
            case let .loaded(items, _, _) = state,
            let item = items.first(where: { $0.id == id }),
            let message = item as? ConversationViewMessageItem else {
            return
        }
        view?.set(replyToMessage: message)
    }

    func didTapMessagePreview(withId id: UUID) {
        view?.scrollToItem(withId: id)
    }
    
    func didTapScanDocumentButton() {
        view?.displayDocumentScanner()
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
        isTypingSubject.send(!text.isEmpty)
    }

    func didReachEndOfConversation() {
        guard let loadMore = conversationItems?.data.loadMore, loadMoreItemsAction == nil else { return }
        loadMoreItemsAction = Task(priority: .userInitiated, operation: {
            do {
                try await loadMore()
            } catch {
                logger.warning(message: "Failed to load more items", error: error)
                view?.showErrorAlert(
                    viewModel: .init(
                        title: L10n.conversationLoadMoreErrorTitle,
                        message: L10n.conversationLoadMoreErrorMessage,
                        defaultAction: L10n.conversationLoadMoreErrorAlertAction
                    )
                )
            }
            loadMoreItemsAction = nil
        })
    }
    
    func didTapDeleteMessageButton(withId messageId: UUID) {
        Task(priority: .userInitiated) {
            do {
                try await client.deleteMessage(withId: messageId, conversationId: conversationId)
            } catch {
                logger.warning(message: "Failed to delete message", error: error)
                view?.showErrorAlert(
                    viewModel: .init(
                        title: L10n.conversationDeleteMessageErrorTitle,
                        message: L10n.conversationDeleteMessageErrorMessage,
                        defaultAction: L10n.conversationDeleteMessageErrorAlertAction
                    )
                )
            }
        }
    }

    func didTap(image: ImageFile) {
        view?.displayImageDetail(for: image)
    }

    func didTap(document: DocumentFile) {
        view?.displayDocumentDetail(for: document)
    }

    func didTapTextItem(withId id: UUID) {
        guard case .me = (conversationItems?.data.elements.first(where: { $0.id == id }) as? TextMessageItem)?.sender else {
            return
        }
        if id == focusedPatientTextItemId {
            focusedPatientTextItemId = nil
        } else {
            focusedPatientTextItemId = id
        }
    }
    
    func didTapJoinVideoCall(url: String, token: String) {
        view?.displayVideoCallRoom(url: url, token: token)
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
    private var conversationItems: Response<PaginatedList<ConversationItem>>?
    private var draftText: String = ""
    private var didRecentlySendNewMessage = false
    private var state: ConversationViewState = .loading {
        didSet { view?.configure(withState: state) }
    }

    private var focusedPatientTextItemId: UUID? {
        didSet { updateConversationItems() }
    }

    private var itemsWatcher: AnyCancellable?
    private var conversationWatcher: AnyCancellable?
    private var loadMoreItemsAction: Task<Void, Never>?
    private let isTypingSubject = PassthroughSubject<Bool, Never>()
    private var isTypingObserver: AnyCancellable?
    
    private var canRecordAudio: Bool {
        Bundle.main.nabla.hasMicrophoneUsageDescription
    }

    private func watchItems() {
        state = .loading
        
        conversationWatcher = client.watchConversation(withId: conversationId)
            .nabla.drive(receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.conversation = response.data
                let conversationViewModel = Self.transform(conversation: response.data)
                self.view?.configure(withConversation: conversationViewModel)
                self.updateConversationItems()
            }, receiveError: { [weak self] error in
                guard let self = self else { return }
                self.logger.warning(message: "Failed to watch conversation", error: error)
                self.state = .error(viewModel: .init(message: L10n.conversationLoadErrorLabel, buttonTitle: L10n.conversationListButtonRetry))
            })
        
        itemsWatcher = client.watchItems(ofConversationWithId: conversationId)
            .nabla.drive(receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.conversationItems = response
                self.updateConversationItems()
                self.markConversationAsSeen()
                if self.didRecentlySendNewMessage, let firstItem = response.data.elements.first {
                    self.view?.scrollToItem(withId: firstItem.id)
                    self.didRecentlySendNewMessage = false
                }
            }, receiveError: { [weak self] error in
                guard let self = self else { return }
                self.logger.warning(message: "Failed to watch messages", error: error)
                self.state = .error(viewModel: .init(message: L10n.conversationLoadErrorLabel, buttonTitle: L10n.conversationListButtonRetry))
            })
    }
    
    private func markConversationAsSeen() {
        Task(priority: .userInitiated) {
            do {
                try await self.client.markConversationAsSeen(conversationId)
            } catch {
                logger.warning(message: "Failed to mark conversation as seen", error: error)
            }
        }
    }
    
    private func observeIsTyping() {
        isTypingObserver = isTypingSubject
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.global(qos: .userInitiated))
            .sink { [weak self] isTyping in
                guard let self = self else { return }
                Task(priority: .userInitiated) {
                    do {
                        try await self.client.setIsTyping(isTyping, inConversationWithId: self.conversationId)
                    } catch {
                        self.logger.warning(message: "Failed to set is typing", error: error)
                    }
                }
            }
    }
    
    private static func transform(conversation: Conversation) -> ConversationViewModel {
        ConversationViewModel(
            title: conversation.title ?? conversation.inboxPreviewTitle,
            subtitle: conversation.subtitle,
            avatar: AvatarViewModelTransformer.avatar(for: conversation)
        )
    }

    /// Updates the content of the conversation. Its items, but also other elements that might appear in the list (example: typing indicators)
    private func updateConversationItems() {
        guard let conversationItems = conversationItems else { return }
        let viewItems = ConversationItemsTransformer.transform(
            conversationItems: conversationItems.data,
            providers: conversation?.providers ?? [],
            focusedTextItemId: focusedPatientTextItemId
        )
        state = .loaded(
            items: viewItems,
            showComposer: !(conversation?.isLocked ?? false),
            isRefreshing: conversationItems.refreshingState.isRefreshing
        )
    }
}

private extension Media {
    var messageInput: MessageInput? {
        if let audioFile = self as? AudioFile {
            return .audio(content: audioFile)
        } else if let documentFile = self as? DocumentFile {
            return .document(content: documentFile)
        } else if let imageFile = self as? ImageFile {
            return .image(content: imageFile)
        } else if let videoFile = self as? VideoFile {
            return .video(content: videoFile)
        }
        return nil
    }
}
