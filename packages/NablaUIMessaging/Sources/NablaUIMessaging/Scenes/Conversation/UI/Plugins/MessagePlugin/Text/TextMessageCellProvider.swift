import Foundation
import UIKit

final class TextMessageCellProvider: ConversationCellProvider {
    private typealias Cell = ConversationMessageCell<TextMessageContentView>

    private var presenters: [UUID: TextMessagePresenter] = [:]

    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? TextMessageViewItem else {
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
        item: TextMessageViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> TextMessagePresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = TextMessagePresenter(delegate: delegate, item: item)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
