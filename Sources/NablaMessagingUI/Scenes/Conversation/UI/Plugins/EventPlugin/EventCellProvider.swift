import Foundation
import UIKit

final class EventCellProvider: ConversationCellProvider {
    private typealias Cell = ConversationTextSeparatorCell
    
    private var presenters: [UUID: EventPresenter] = [:]
    
    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? EventViewItem else {
            return nil
        }
        
        let cell = collectionView.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            item: item,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
        return cell
    }
    
    private func findOrCreatePresenter(
        item: EventViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> EventPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = EventPresenter(delegate: delegate, item: item)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
