import Foundation

final class DateSeparatorPresenter: Presenter {
    var content: DateSeparatorItemContent

    // MARK: - Init

    init(delegate: ConversationCellPresenterDelegate, id: UUID, content: DateSeparatorItemContent) {
        self.content = content
        self.id = id
        self.delegate = delegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.delegate?.didUpdateState(forItemWithId: self.id)
        }
    }

    // MARK: - Presenter

    func start() {
        updateView()
    }

    // MARK: - Internal

    func attachView(_ view: DateSeparatorViewContract) {
        self.view = view
    }

    func updateView() {
        view?.configure(content: content)
    }

    // MARK: - Private

    private let id: UUID
    private weak var delegate: ConversationCellPresenterDelegate?
    private weak var view: DateSeparatorViewContract?
}
