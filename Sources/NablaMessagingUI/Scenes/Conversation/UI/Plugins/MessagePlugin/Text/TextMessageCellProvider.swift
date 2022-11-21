import Foundation
import NablaCore
import NablaMessagingCore
import UIKit

final class TextMessageCellProvider: ConversationCellProvider {
    // MARK: - Internal
    
    func prepare(collectionView: UICollectionView) {
        collectionView.nabla.register(Cell.self)
    }
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        viewController _: UIViewController?,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? TextMessageViewItem else {
            return nil
        }
        
        let cell = collectionView.nabla.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            item: item,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
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
    
    private typealias Cell = ConversationMessageCell<TextMessageContentView>

    private let logger: Logger
    private let client: NablaMessagingClientProtocol
    private let conversationId: UUID
    private var presenters: [UUID: TextMessagePresenter] = [:]
    
    private func findOrCreatePresenter(
        item: TextMessageViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> TextMessagePresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = TextMessagePresenter(
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
