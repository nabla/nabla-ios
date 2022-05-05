import Foundation
import NablaMessagingCore
import UIKit

final class DocumentMessageCellProvider: ConversationCellProvider {
    // MARK: Initializer
    
    init(
        conversationId: UUID,
        client: NablaClient
    ) {
        self.conversationId = conversationId
        self.client = client
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
        guard let item = item as? DocumentMessageViewItem else {
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
    
    private typealias Cell = ConversationMessageCell<DocumentMessageContentView>
    
    private let client: NablaClient
    private let conversationId: UUID
    
    private var presenters: [UUID: DocumentMessagePresenter] = [:]
    
    private func findOrCreatePresenter(
        item: DocumentMessageViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> DocumentMessagePresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = DocumentMessagePresenter(
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
