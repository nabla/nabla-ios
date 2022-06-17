import Foundation
import NablaMessagingCore

final class VideoMessagePresenter:
    MessagePresenter<
        VideoMessageContentView,
        VideoMessageViewItem,
        ConversationMessageCell<VideoMessageContentView>
    > {
    // MARK: - Init
    
    init(
        logger: Logger,
        item: VideoMessageViewItem,
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
            transformContent: VideoMessageContentViewModelTransformer.transform
        )
    }
}
