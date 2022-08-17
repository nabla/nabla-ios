import Foundation
import NablaCore
import NablaMessagingCore
import UIKit

final class VideoCallActionRequestCellProvider: ConversationCellProvider {
    // MARK: - Internal
    
    func prepare(collectionView: UICollectionView) {
        collectionView.nabla.register(Cell.self)
    }
    
    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> UICollectionViewCell? {
        guard let item = item as? VideoCallActionRequestViewItem else {
            return nil
        }
        
        let cell = collectionView.nabla.dequeueReusableCell(ofClass: Cell.self, for: indexPath)
        let presenter = findOrCreatePresenter(
            item: item,
            delegate: delegate
        )
        presenter.attachView(cell)
        cell.configure(presenter: presenter)
        cell.content.configure(presenter: presenter)
        return cell
    }
    
    init(
        logger: Logger,
        conversationId: UUID,
        client: NablaMessagingClientProtocol,
        videoCallClient: VideoCallClient
    ) {
        self.logger = logger
        self.conversationId = conversationId
        self.client = client
        self.videoCallClient = videoCallClient
    }
    
    // MARK: - Private
    
    private typealias Cell = ConversationMessageCell<VideoCallActionRequestContentView>

    private let logger: Logger
    private let client: NablaMessagingClientProtocol
    private let videoCallClient: VideoCallClient
    private let conversationId: UUID
    private var presenters: [UUID: VideoCallActionRequestPresenter] = [:]
    
    private func findOrCreatePresenter(
        item: VideoCallActionRequestViewItem,
        delegate: ConversationCellPresenterDelegate
    ) -> VideoCallActionRequestPresenter {
        if let presenter = presenters[item.id] {
            presenter.item = item
            return presenter
        } else {
            let presenter = VideoCallActionRequestPresenter(
                logger: logger,
                item: item,
                conversationId: conversationId,
                client: client,
                videoCallClient: videoCallClient,
                delegate: delegate
            )
            presenters[item.id] = presenter
            return presenter
        }
    }
}
