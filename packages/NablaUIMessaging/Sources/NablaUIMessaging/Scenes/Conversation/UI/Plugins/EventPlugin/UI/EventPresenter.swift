import Foundation

final class EventPresenter: Presenter {
    var content: EventItemContent

    // MARK: - Init

    init(delegate _: ConversationCellPresenterDelegate, id _: UUID, content: EventItemContent) {
        self.content = content
    }

    // MARK: - Presenter

    func start() {
        updateView()
    }

    // MARK: - Internal

    func attachView(_ view: EventCellContract) {
        self.view = view
    }

    // MARK: - Private

    private weak var view: EventCellContract?

    private func updateView() {
        view?.configure(with: .init(message: content.text))
    }
}
