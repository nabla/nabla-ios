import Foundation
import UIKit

final class HasMoreIndicatorCellProvider: ConversationCellProvider {
    // MARK: - Internal
    
    func prepare(collectionView: UICollectionView) {
        collectionView.register(HasMoreIndicatorCell.self)
    }
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? HasMoreIndicatorViewItem else {
            return nil
        }
        
        let cell = collectionView.dequeueReusableCell(ofClass: HasMoreIndicatorCell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            item: item,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
        return cell
    }
    
    init(
        conversationId: UUID
    ) {
        self.conversationId = conversationId
    }
    
    // MARK: - Private
    
    private let conversationId: UUID
    private var presenters: [UUID: HasMoreIndicatorPresenter] = [:]
    
    private func findOrCreatePresenter(
        item: HasMoreIndicatorViewItem,
        delegate _: ConversationCellPresenterDelegate
    ) -> HasMoreIndicatorPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = HasMoreIndicatorPresenter(item: item)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
