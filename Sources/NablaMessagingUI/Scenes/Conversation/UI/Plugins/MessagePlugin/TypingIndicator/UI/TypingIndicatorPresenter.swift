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
        logger: Logger,
        item: TypingIndicatorViewItem,
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
    
    // MARK: - Private
    
    private static func transform(item _: TypingIndicatorViewItem) -> TypingIndicatorContentView.ContentViewModel {
        ()
    }
}
