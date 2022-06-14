import Foundation
import NablaMessagingCore
import UIKit

final class DeletedMessageCellProvider: ConversationCellProvider {
    // MARK: - Internal
    
    func prepare(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? DeletedMessageViewItem else {
            return nil
        }
        
        let cell = collectionView.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            item: item,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
        cell.allowSwipeGesture = false
        return cell
    }
    
    init(
        logger: Logger,
        conversationId: UUID,
        client: NablaMessagingClientProtocol
    ) {
        self.logger = logger
        self.conversationId = conversationId
        self.client = client
    }
    
    // MARK: - Private
    
    private typealias Cell = ConversationMessageCell<DeletedMessageContentView>

    private let logger: Logger
    private let client: NablaMessagingClientProtocol
    private let conversationId: UUID
    private var presenters: [UUID: DeletedMessagePresenter] = [:]
    
    private func findOrCreatePresenter(
        item: DeletedMessageViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> DeletedMessagePresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = DeletedMessagePresenter(
                logger: logger,
                item: item,
                conversationId: conversationId,
                client: client,
                delegate: delegate
            )
            presenters[item.id] = presenter
            return presenter
        }
    }
}
