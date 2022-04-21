import Foundation

final class TextMessagePresenter:
    MessagePresenter<
        TextMessageContentView,
        TextMessageViewItem,
        ConversationMessageCell<TextMessageContentView>
    > {
    // MARK: - Init

    init(
        delegate: ConversationCellPresenterDelegate,
        item: TextMessageViewItem
    ) {
        super.init(
            delegate: delegate,
            item: item,
            transformContent: Self.transform
        )
    }

    // MARK: - Private

    // TODO: - Move the transform to a separate class ?
    private static func transform(item: TextMessageViewItem) -> TextMessageContentView.ContentViewModel {
        .init(text: item.text)
    }
}
