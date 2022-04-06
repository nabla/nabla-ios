import Foundation

final class ConversationPresenterImpl: ConversationPresenter {
    private var items = [ConversationViewItem]()

    // MARK: Init

    init(view: ConversationViewContract) {
        self.view = view
    }

    // MARK: - Internal

    func start() {
        view?.configure(withState: .loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view?.configure(withState: .error)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.view?.configure(withState: .loading)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.view?.configure(withState: .empty)
        }

        for i in 1 ... 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(7 + i * 2)) {
                self.items.append(ConversationViewItem(content: DateSeparatorItemContent(text: Date().description)))
                self.view?.configure(withState: .loaded(items: self.items))
            }
        }
    }

    // MARK: - Private

    private weak var view: ConversationViewContract?
}
