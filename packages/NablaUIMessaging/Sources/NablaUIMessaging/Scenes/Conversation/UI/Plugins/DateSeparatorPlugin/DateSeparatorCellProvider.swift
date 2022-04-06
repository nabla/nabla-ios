import Foundation
import UIKit

struct DateSeparatorCellProvider: ConversationCellProvider {
    private typealias Cell = HostingCollectionViewCell<DateSeparatorView>

    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem
    ) -> UICollectionViewCell? {
        guard let content = item.content as? DateSeparatorItemContent else {
            return nil
        }

        let cell = collectionView.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        cell.configure(with: content)
        return cell
    }
}
