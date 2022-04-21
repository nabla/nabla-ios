import Foundation

class MessagePresenter<
    ContentView,
    Item: ConversationViewMessageItem,
    MessageCellContract: ConversationMessageCellContract
>: Presenter where MessageCellContract.ContentView == ContentView {
    typealias Cell = ConversationMessageCell<ContentView>

    var item: Item

    // MARK: - Init

    init(
        delegate _: ConversationCellPresenterDelegate,
        item: Item,
        transformContent: @escaping (Item) -> ContentView.ContentViewModel
    ) {
        self.item = item
        self.transformContent = transformContent
    }

    // MARK: - Presenter

    func start() {
        updateView()
    }

    // MARK: - Internal

    func attachView(_ view: MessageCellContract) {
        self.view = view
    }

    // MARK: - Private

    private weak var view: MessageCellContract?
    private let transformContent: (Item) -> ContentView.ContentViewModel

    private func transformSender() -> ConversationMessageSender {
        switch item.sender {
        case let .provider(_, avatarURL):
            return .them(.init(author: "Provider", avatar: .init(url: avatarURL, text: nil), displaySenderNameAndAvatar: true))
        case .patient:
            return .me
        }
    }

    private func updateView() {
        view?.configure(with: .init(
            sender: transformSender(),
            footer: transformFooter(),
            content: transformContent(item)
        ))
    }

    private func transformFooter() -> ConversationMessageFooterViewModel? {
        switch item.state {
        case .sending:
            return .init(text: "Sending", color: .lightGray)
        case .sent:
            return nil
        case .failed:
            return .init(text: "Failed", color: .red)
        }
    }
}
