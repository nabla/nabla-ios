import Foundation
import NablaMessagingCore

final class DocumentMessagePresenter:
    MessagePresenter<
        DocumentMessageContentView,
        DocumentMessageViewItem,
        ConversationMessageCell<DocumentMessageContentView>
    > {
    // MARK: - Init
        
    init(
        logger: Logger,
        item: DocumentMessageViewItem,
        conversationId: UUID,
        client: NablaMessagingClientProtocol,
        delegate: ConversationCellPresenterDelegate
    ) {
        super.init(
            logger: logger,
            item: item,
            conversationId: conversationId,
            client: client,
            delegate: delegate,
            transformContent: DocumentMessageContentViewModelTransformer.transform
        )
    }
    
    override func userDidTapContent() {
        delegate?.didTapMedia(item.document)
    }
}
