import Foundation

final class ImageMessagePresenter:
    MessagePresenter<
        ImageMessageContentView,
        ImageMessageViewItem,
        ConversationMessageCell<ImageMessageContentView>
    > {
    // MARK: - Init

    init(
        delegate: ConversationCellPresenterDelegate,
        item: ImageMessageViewItem,
        conversationId: UUID
    ) {
        super.init(
            delegate: delegate,
            item: item,
            conversationId: conversationId,
            transformContent: Self.transform
        )
    }

    // MARK: - Private

    // TODO: - Move the transform to a separate class ?
    private static func transform(item: ImageMessageViewItem) -> ImageMessageContentView.ContentViewModel {
        .init(url: item.image.fileUrl)
    }
}
