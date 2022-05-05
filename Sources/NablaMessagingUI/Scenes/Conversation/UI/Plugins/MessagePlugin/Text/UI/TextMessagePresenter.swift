import Foundation
import NablaMessagingCore

final class TextMessagePresenter:
    MessagePresenter<
        TextMessageContentView,
        TextMessageViewItem,
        ConversationMessageCell<TextMessageContentView>
    > {
    // MARK: - Init
    
    init(
        item: TextMessageViewItem,
        conversationId: UUID,
        client: NablaClient,
        delegate: ConversationCellPresenterDelegate
    ) {
        super.init(
            item: item,
            conversationId: conversationId,
            client: client,
            delegate: delegate,
            transformContent: Self.transform
        )
    }
    
    // MARK: - Private
    
    // TODO: - Move the transform to a separate class ?
    private static func transform(item: TextMessageViewItem) -> TextMessageContentView.ContentViewModel {
        .init(text: item.text)
    }
}
