import Foundation
import UIKit

final class EventCellProvider: ConversationCellProvider {
    private typealias Cell = EventCell

    private var presenters: [UUID: EventPresenter] = [:]

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
        guard let content = content as? EventItemContent else {
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
        content: EventItemContent,
        delegate: ConversationCellPresenterDelegate
    ) -> EventPresenter {
        if let presenter = presenters[id] {
            presenter.content = content
            return presenter
        } else {
            let presenter = EventPresenter(delegate: delegate, id: id, content: content)
            presenters[id] = presenter
            return presenter
        }
    }
}
