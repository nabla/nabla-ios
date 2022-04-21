import Foundation

final class DateSeparatorPresenter: Presenter {
    var item: DateSeparatorViewItem

    // MARK: - Init

    init(delegate: ConversationCellPresenterDelegate, item: DateSeparatorViewItem) {
        self.item = item
        self.delegate = delegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.localText = "\nline 2"
            self.delegate?.didUpdateState(forItemWithId: item.id)
        }
    }

    // MARK: - Presenter

    func start() {
        updateView()
    }

    // MARK: - Internal

    func attachView(_ view: EventCellContract) {
        self.view = view
    }

    func updateView() {
        view?.configure(with: .init(message: item.text + (localText ?? "")))
    }

    // MARK: - Private

    private var localText: String?
    private weak var delegate: ConversationCellPresenterDelegate?
    private weak var view: EventCellContract?
}
