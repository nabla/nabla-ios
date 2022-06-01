import Foundation
import NablaMessagingCore
import UIKit

final class DeletedMessagePresenter:
    MessagePresenter<
        DeletedMessageContentView,
        DeletedMessageViewItem,
        ConversationMessageCell<DeletedMessageContentView>
    > {
    // MARK: - Init
    
    init(
        logger: Logger,
        item: DeletedMessageViewItem,
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
            transformContent: DeletedMessageContentViewModelTransformer.transform
        )
    }
    
    // MARK: - Internal
    
    override func makeMenuElements(_: DeletedMessageViewItem) -> [UIMenuElement] {
        []
    }
}
