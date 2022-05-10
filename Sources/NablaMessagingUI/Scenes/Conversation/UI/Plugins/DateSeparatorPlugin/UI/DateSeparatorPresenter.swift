import Foundation

final class DateSeparatorPresenter: Presenter {
    var item: DateSeparatorViewItem

    // MARK: - Init

    init(delegate _: ConversationCellPresenterDelegate, item: DateSeparatorViewItem) {
        self.item = item
    }

    // MARK: - Presenter

    func start() {
        updateView()
    }

    // MARK: - Internal

    func attachView(_ view: ConversationTextSeparatorCellContract) {
        self.view = view
    }

    // MARK: - Private

    private weak var view: ConversationTextSeparatorCellContract?

    private func updateView() {
        let mapper = DateSeparatorViewModelMapper()
        let viewModel = mapper.map(item: item)
        view?.configure(with: viewModel)
    }
}
