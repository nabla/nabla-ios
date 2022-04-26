import Foundation

final class TypingIndicatorPresenter:
    MessagePresenter<
        TypingIndicatorContentView,
        TypingIndicatorViewItem,
        ConversationMessageCell<TypingIndicatorContentView>
    > {
    // MARK: - Init

    init(
        delegate: ConversationCellPresenterDelegate,
        item: TypingIndicatorViewItem,
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

    private static func transform(item _: TypingIndicatorViewItem) -> TypingIndicatorContentView.ContentViewModel {
        ()
    }
}
