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
        id: UUID,
        content: ConversationViewItemContent,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let content = content as? TextMessageItemContent else {
            return nil
        }

        let cell = collectionView.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            id: id,
            content: content,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
        return cell
    }

    private func findOrCreatePresenter(
        id: UUID,
        content: TextMessageItemContent,
        delegate: ConversationCellPresenterDelegate
    ) -> TextMessagePresenter {
        if let presenter = presenters[id] {
            presenter.content = content
            return presenter
        } else {
            let presenter = TextMessagePresenter(delegate: delegate, id: id, content: content)
            presenters[id] = presenter
            return presenter
        }
    }
}
