import Foundation
import NablaMessagingCore

extension ConversationViewController {
    static func create(conversationId: UUID, client: NablaMessagingClientProtocol, logger: Logger) -> Self {
        .init(
            logger: logger,
            providers: [
                DateSeparatorCellProvider(),
                ConversationActivityCellProvider(),
                TextMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
                TypingIndicatorCellProvider(logger: logger, conversationId: conversationId, client: client),
                DeletedMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
                ImageMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
                DocumentMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
                HasMoreIndicatorCellProvider(conversationId: conversationId),
            ]
        )
    }
}
