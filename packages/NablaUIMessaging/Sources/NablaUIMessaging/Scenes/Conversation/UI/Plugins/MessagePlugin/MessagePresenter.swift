import Foundation
import NablaCore
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
        delegate: ConversationCellPresenterDelegate,
        item: Item,
        conversationId: UUID,
        transformContent: @escaping (Item) -> ContentView.ContentViewModel
    ) {
        self.delegate = delegate
        self.item = item
        self.conversationId = conversationId
        self.transformContent = transformContent
    }

    // MARK: - Presenter

    func start() {
        updateView()
    }

    func userDidTapFooter() {
        switch item.state {
        case .failed:
            retrySendingMessage()
        case .sending, .sent:
            break
        }
    }

    func userDidTapContent() {}

    // MARK: - Internal

    func attachView(_ view: MessageCellContract) {
        self.view = view
    }

    func makeMenuElements(_ item: Item) -> [UIMenuElement] {
        if item.sender == .patient, item.state == .sent {
            let deleteAction = UIAction(
                title: L10n.conversationActionDelete,
                image: UIImage(systemName: "trash"),
                attributes: .destructive,
                handler: { [weak self] _ in self?.delegate?.didDeleteItem(withId: item.id) }
            )
            return [deleteAction]
        }
        return []
    }
    
    // MARK: - Private

    private weak var view: MessageCellContract?
    private let conversationId: UUID
    private weak var delegate: ConversationCellPresenterDelegate?

    private let transformContent: (Item) -> ContentView.ContentViewModel

    private var retrySendingAction: Cancellable?

    private func transformSender() -> ConversationMessageSender {
        switch item.sender {
        case let .provider(provider):
            return .them(.init(
                author: "Provider",
                avatar: .init(url: provider.avatarURL, text: nil),
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
        switch item.state {
        case .sending:
            // TODO: L10n
            return .init(text: "Sending", color: .lightGray)
        case .sent:
            return nil
        case .failed:
            // TODO: L10n
            return .init(text: "Failed", color: .red)
        }
    }

    private func retrySendingMessage() {
        guard retrySendingAction == nil else { return }
        retrySendingAction = NablaClient.shared.retrySending(itemWithId: item.id, inConversationWithId: conversationId) { [weak self] result in
            switch result {
            case let .failure(error):
                print(error) // TODO: @tgy Error handling
            case .success:
                break
            }
            self?.retrySendingAction = nil
        }
    }
}
