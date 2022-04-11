import Foundation
import UIKit

protocol ConversationCellProvider {
    func prepare(collectionView: UICollectionView)

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        id: UUID,
        content: ConversationViewItemContent,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell?
}
