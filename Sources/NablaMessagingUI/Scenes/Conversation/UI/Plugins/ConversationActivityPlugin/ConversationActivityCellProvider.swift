import Foundation
import UIKit

final class ConversationActivityCellProvider: ConversationCellProvider {
    private typealias Cell = ConversationTextSeparatorCell
    
    private var presenters: [UUID: ConversationActivityPresenter] = [:]
    
    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? ConversationActivityViewItem else {
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
        item: ConversationActivityViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> ConversationActivityPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = ConversationActivityPresenter(delegate: delegate, item: item)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
