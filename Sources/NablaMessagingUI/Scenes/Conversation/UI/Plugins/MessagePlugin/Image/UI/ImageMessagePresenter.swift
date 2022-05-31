import Foundation
import NablaMessagingCore

final class ImageMessagePresenter:
    MessagePresenter<
        ImageMessageContentView,
        ImageMessageViewItem,
        ConversationMessageCell<ImageMessageContentView>
    > {
    // MARK: - Init
    
    init(
        logger: Logger,
        item: ImageMessageViewItem,
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
            transformContent: Self.transform
        )
    }
    
    override func userDidTapContent() {
        delegate?.didTapMedia(item.image)
    }
    
    // MARK: - Private
    
    // TODO: - Move the transform to a separate class ?
    private static func transform(item: ImageMessageViewItem) -> ImageMessageContentView.ContentViewModel {
        .init(url: item.image.fileUrl)
    }
}
