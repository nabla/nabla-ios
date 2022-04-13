import Foundation

final class DateSeparatorPresenter: Presenter {
    var content: DateSeparatorItemContent

    // MARK: - Init

    init(delegate: ConversationCellPresenterDelegate, id: UUID, content: DateSeparatorItemContent) {
        self.content = content
        self.id = id
        self.delegate = delegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.localText = "\nline 2"
            self.delegate?.didUpdateState(forItemWithId: self.id)
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
        view?.configure(with: .init(message: content.text + (localText ?? "")))
    }

    // MARK: - Private

    private let id: UUID
    private var localText: String?
    private weak var delegate: ConversationCellPresenterDelegate?
    private weak var view: EventCellContract?
}
