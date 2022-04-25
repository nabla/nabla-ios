import Foundation
import UIKit

final class TypingIndicatorCellProvider: ConversationCellProvider {
    private typealias Cell = ConversationMessageCell<TypingIndicatorContentView>

    private var presenters: [UUID: TypingIndicatorPresenter] = [:]

    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? TypingIndicatorViewItem else {
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
        item: TypingIndicatorViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> TypingIndicatorPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = TypingIndicatorPresenter(delegate: delegate, item: item)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
