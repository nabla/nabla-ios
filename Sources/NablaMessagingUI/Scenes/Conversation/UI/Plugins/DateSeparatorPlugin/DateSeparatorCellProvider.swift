import Foundation
import UIKit

final class DateSeparatorCellProvider: ConversationCellProvider {
    private var presenters: [UUID: DateSeparatorPresenter] = [:]

    func prepare(collectionView: UICollectionView) {
        collectionView.nabla.register(DateSeparatorCell.self)
    }

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        viewController _: UIViewController?,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? DateSeparatorViewItem else {
            return nil
        }

        let cell = collectionView.nabla.dequeueReusableCell(ofClass: DateSeparatorCell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            item: item,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
        return cell
    }

    private func findOrCreatePresenter(
        item: DateSeparatorViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> DateSeparatorPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = DateSeparatorPresenter(delegate: delegate, item: item)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
