import Foundation
import NablaCore
import NablaMessagingCore

import UIKit

class MessagePresenter<
    ContentView,
    Item: ConversationViewMessageItem,
    MessageCellContract: ConversationMessageCellContract
>: ConversationMessagePresenter where MessageCellContract.ContentView == ContentView {
    var item: Item
    weak var delegate: ConversationCellPresenterDelegate?

    // MARK: - Init
    
    init(
        logger: Logger,
        item: Item,
        conversationId: UUID,
        client: NablaMessagingClientProtocol,
        delegate: ConversationCellPresenterDelegate,
        transformContent: @escaping (Item) -> ContentView.ContentViewModel
    ) {
        self.logger = logger
        self.item = item
        self.conversationId = conversationId
        self.client = client
        self.delegate = delegate
        self.transformContent = transformContent
    }
    
    // MARK: - Presenter
    
    func start() {
        updateView()
    }
    
    func userDidTapFooter() {
        switch item.sendingState {
        case .failed:
            retrySendingMessage()
        case .sending, .sent, .toBeSent:
            break
        }
    }
    
    func userDidTapContent() {}

    func userDidSwipeSuccessfully() {
        delegate?.didReplyToItem(withId: item.id)
    }

    func updateView() {
        view?.configure(with: .init(
            sender: transformSender(),
            footer: transformFooter(),
            replyTo: transformReplyTo(),
            content: transformContent(item),
            menuElements: makeMenuElements(item)
        ))
    }

    func userDidTapMessagePreview() {
        guard let id = item.replyTo?.id else { return }
        delegate?.didTapMessagePreview(withId: id)
    }

    func didFailContentConfig(underlyingError: Error) {
        logger.error(
            message: "Cell content configuration failed (itemType: \(type(of: item)))",
            error: InternalError(underlyingError: underlyingError)
        )
    }

    // MARK: - Internal
    
    func attachView(_ view: MessageCellContract) {
        self.view = view
    }
    
    func makeMenuElements(_ item: Item) -> [UIMenuElement] {
        var actions: [UIAction] = []
        if item.sendingState == .sent {
            let replyAction = UIAction(
                title: L10n.conversationActionReplyTo,
                image: UIImage(systemName: "arrowshape.turn.up.left"),
                handler: { [weak self] _ in self?.delegate?.didReplyToItem(withId: item.id) }
            )
            actions.append(replyAction)
        }
        if item.sender == .me, item.sendingState == .sent {
            let deleteAction = UIAction(
                title: L10n.conversationActionDeleteMessage,
                image: UIImage(systemName: "trash"),
                attributes: .destructive,
                handler: { [weak self] _ in self?.delegate?.didDeleteItem(withId: item.id) }
            )
            actions.append(deleteAction)
        }
        return actions
    }
    
    // MARK: - Private

    private let logger: Logger
    
    private let conversationId: UUID
    private let client: NablaMessagingClientProtocol
    private let transformContent: (Item) -> ContentView.ContentViewModel

    private(set) weak var view: MessageCellContract?
    
    private func transformSender() -> ConversationMessageSender {
        ConversationMessageSenderTransformer.transform(item: item)
    }

    private func transformFooter() -> ConversationMessageFooterViewModel? {
        ConversationMessageFooterViewModelTransformer.transform(item: item)
    }

    private func transformReplyTo() -> ConversationMessagePreviewViewModel? {
        guard !(item is DeletedMessageViewItem) else { return nil }
        return ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)
    }
    
    private func retrySendingMessage() {
        Task(priority: .userInitiated) {
            do {
                try await client.retrySending(itemWithId: item.id, inConversationWithId: conversationId)
            } catch {
                logger.warning(message: "Failed send retry", error: error)
            }
        }
    }
}
