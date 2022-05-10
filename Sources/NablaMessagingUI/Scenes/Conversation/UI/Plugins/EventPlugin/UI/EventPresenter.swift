import Foundation

final class EventPresenter: Presenter {
    var item: EventViewItem
    
    // MARK: - Init
    
    init(delegate _: ConversationCellPresenterDelegate, item: EventViewItem) {
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
        view?.configure(with: .init(text: item.text))
    }
}
