import Foundation

final class ConversationPresenterImpl: ConversationPresenter {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.view?.configure(withState: .loaded(items: [.text]))
        }
    }

    // MARK: - Private

    private weak var view: ConversationViewContract?
}
