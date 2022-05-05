import Foundation
import NablaMessagingCore

final class TypingIndicatorPresenter:
    MessagePresenter<
        TypingIndicatorContentView,
        TypingIndicatorViewItem,
        ConversationMessageCell<TypingIndicatorContentView>
    > {
    // MARK: - Init
    
    init(
        item: TypingIndicatorViewItem,
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
    
    private static func transform(item _: TypingIndicatorViewItem) -> TypingIndicatorContentView.ContentViewModel {
        ()
    }
}
