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

    func attachView(_ view: DateSeparatorCell) {
        self.view = view
    }

    // MARK: - Private

    private weak var view: DateSeparatorCell?

    private func updateView() {
        let transformer = DateSeparatorViewModelTransformer()
        let viewModel = transformer.transform(item: item)
        view?.configure(with: viewModel)
    }
}
