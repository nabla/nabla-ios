import Foundation
import NablaMessagingCore
import UIKit

final class TypingIndicatorCellProvider: ConversationCellProvider {
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
    
    init(
        conversationId: UUID,
        client: NablaClient
    ) {
        self.conversationId = conversationId
        self.client = client
    }
    
    // MARK: - Private
    
    private typealias Cell = ConversationMessageCell<TypingIndicatorContentView>
    
    private let client: NablaClient
    private let conversationId: UUID
    private var presenters: [UUID: TypingIndicatorPresenter] = [:]
    
    private func findOrCreatePresenter(
        item: TypingIndicatorViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> TypingIndicatorPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = TypingIndicatorPresenter(
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
