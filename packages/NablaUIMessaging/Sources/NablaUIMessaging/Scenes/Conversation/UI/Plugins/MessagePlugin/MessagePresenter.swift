import Foundation

class MessagePresenter<
    ContentView,
    ContentItem: ConversationViewItemContent,
    MessageCellContract: ConversationMessageCellContract
>: Presenter where MessageCellContract.ContentView == ContentView {
    typealias Cell = ConversationMessageCell<ContentView>

    var content: ContentItem

    // MARK: - Init

    init(
        delegate _: ConversationCellPresenterDelegate,
        id _: UUID,
        content: ContentItem,
        transform: @escaping (ContentItem) -> ConversationMessageViewModel<ContentView.ContentViewModel>
    ) {
        self.content = content
        self.transform = transform
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
    private let transform: (ContentItem) -> ConversationMessageViewModel<ContentView.ContentViewModel>

    private func updateView() {
        view?.configure(with: transform(content))
    }
}
