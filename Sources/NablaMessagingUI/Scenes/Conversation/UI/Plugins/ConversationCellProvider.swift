import Foundation
import UIKit

// TODO: Factorize shared code between the different ConversationCellProviders
protocol ConversationCellProvider {
    func prepare(collectionView: UICollectionView)
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell?
}
