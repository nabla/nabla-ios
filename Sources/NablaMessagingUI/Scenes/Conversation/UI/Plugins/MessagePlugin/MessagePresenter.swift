import Foundation
import NablaMessagingCore
#if canImport(NablaUtils)
    import NablaUtils
#endif
import UIKit

class MessagePresenter<
    ContentView,
    Item: ConversationViewMessageItem,
    MessageCellContract: ConversationMessageCellContract
>: ConversationMessagePresenter where MessageCellContract.ContentView == ContentView {
    typealias Cell = ConversationMessageCell<ContentView>
    
    var item: Item
    
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
    
    // MARK: - Internal
    
    func attachView(_ view: MessageCellContract) {
        self.view = view
    }
    
    func makeMenuElements(_ item: Item) -> [UIMenuElement] {
        if item.sender == .patient, item.sendingState == .sent {
            let deleteAction = UIAction(
                title: L10n.conversationActionDeleteMessage,
                image: UIImage(systemName: "trash"),
                attributes: .destructive,
                handler: { [weak self] _ in self?.delegate?.didDeleteItem(withId: item.id) }
            )
            return [deleteAction]
        }
        return []
    }
    
    // MARK: - Private

    private let logger: Logger
    
    private let conversationId: UUID
    private let client: NablaMessagingClientProtocol
    private let transformContent: (Item) -> ContentView.ContentViewModel
    
    private weak var view: MessageCellContract?
    private weak var delegate: ConversationCellPresenterDelegate?
    
    private var retrySendingAction: Cancellable?
    
    private func transformSender() -> ConversationMessageSender {
        switch item.sender {
        case let .provider(provider):
            return .them(.init(
                author: [provider.prefix, provider.lastName].compactMap(identity).joined(separator: " "),
                avatar: .init(url: provider.avatarURL, text: provider.initials),
                isContiguous: item.isContiguous
            ))
        case let .system(system):
            return .them(.init(
                author: system.name,
                avatar: .init(url: system.avatarURL, text: system.initials),
                isContiguous: item.isContiguous
            ))
        case .deleted:
            return .them(.init(
                author: L10n.conversationMessageDeletedSender,
                avatar: .init(url: nil, text: nil),
                isContiguous: item.isContiguous
            ))
        case .unknown:
            return .them(.init(
                author: L10n.conversationMessageUnknownSender,
                avatar: .init(url: nil, text: nil),
                isContiguous: item.isContiguous
            ))
        case .patient:
            return .me(isContiguous: item.isContiguous)
        }
    }
    
    private func updateView() {
        view?.configure(with: .init(
            sender: transformSender(),
            footer: transformFooter(),
            content: transformContent(item),
            menuElements: makeMenuElements(item)
        ))
    }
    
    private func transformFooter() -> ConversationMessageFooterViewModel? {
        switch item.sendingState {
        case .sending:
            return .init(text: L10n.conversationMessageStatusSending, color: .lightGray)
        case .sent, .toBeSent:
            return nil
        case .failed:
            return .init(text: L10n.conversationMessageStatusFailed, color: .red)
        }
    }
    
    private func retrySendingMessage() {
        guard retrySendingAction == nil else { return }
        retrySendingAction = client.retrySending(itemWithId: item.id, inConversationWithId: conversationId) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.logger.error(message: "Failed send retry with error: \(error.localizedDescription)")
            case .success:
                break
            }
            self?.retrySendingAction = nil
        }
    }
}
