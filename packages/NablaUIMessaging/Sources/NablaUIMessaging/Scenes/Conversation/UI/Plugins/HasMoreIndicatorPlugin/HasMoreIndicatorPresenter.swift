import Foundation

final class HasMoreIndicatorPresenter: Presenter {
    // MARK: - Init
    
    var item: HasMoreIndicatorViewItem
    
    func start() {}
    
    func attachView(_ view: HasMoreIndicatorViewContract) {
        self.view = view
    }
    
    init(
        item: HasMoreIndicatorViewItem
    ) {
        self.item = item
    }

    // MARK: - Private
    
    private weak var view: HasMoreIndicatorViewContract?
}
