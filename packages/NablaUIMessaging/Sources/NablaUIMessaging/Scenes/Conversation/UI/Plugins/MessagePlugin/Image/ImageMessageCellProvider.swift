import Foundation
import UIKit

final class ImageMessageCellProvider: ConversationCellProvider {
    // MARK: Initializer

    init(conversationId: UUID) {
        self.conversationId = conversationId
    }

    // MARK: - Public

    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? ImageMessageViewItem else {
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

    // MARK: - Private

    private typealias Cell = ConversationMessageCell<ImageMessageContentView>

    private let conversationId: UUID

    private var presenters: [UUID: ImageMessagePresenter] = [:]

    private func findOrCreatePresenter(
        item: ImageMessageViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> ImageMessagePresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = ImageMessagePresenter(delegate: delegate, item: item, conversationId: conversationId)
            presenters[item.id] = presenter
            return presenter
        }
    }
}
