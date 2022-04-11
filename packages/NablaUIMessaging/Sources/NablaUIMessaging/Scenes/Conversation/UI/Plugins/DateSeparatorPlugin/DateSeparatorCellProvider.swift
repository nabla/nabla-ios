import Foundation
import UIKit

final class DateSeparatorCellProvider: ConversationCellProvider {
    private typealias Cell = HostingCollectionViewCell<DateSeparatorView>

    private var presenters: [UUID: DateSeparatorPresenter] = [:]

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
        guard let content = content as? DateSeparatorItemContent else {
            return nil
        }

        let cell = collectionView.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            id: id,
            content: content,
            delegate: delegate
        )
        presenter.attachView(cell.hostedView)
        cell.configure(presenter: presenter)
        return cell
    }

    private func findOrCreatePresenter(
        id: UUID,
        content: DateSeparatorItemContent,
        delegate: ConversationCellPresenterDelegate
    ) -> DateSeparatorPresenter {
        if let presenter = presenters[id] {
            presenter.content = content
            return presenter
        } else {
            let presenter = DateSeparatorPresenter(delegate: delegate, id: id, content: content)
            presenters[id] = presenter
            return presenter
        }
    }
}
