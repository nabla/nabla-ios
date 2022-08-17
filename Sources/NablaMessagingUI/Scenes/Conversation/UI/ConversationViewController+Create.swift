import Foundation
import NablaCore
import NablaMessagingCore

extension ConversationViewController {
    static func create(
        conversationId: UUID,
        showComposer: Bool,
        client: NablaMessagingClientProtocol,
        logger: Logger,
        videoCallClient: VideoCallClient?
    ) -> Self {
        var providers: [ConversationCellProvider] = [
            DateSeparatorCellProvider(),
            ConversationActivityCellProvider(),
            TextMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
            TypingIndicatorCellProvider(logger: logger, conversationId: conversationId, client: client),
            DeletedMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
            ImageMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
            VideoMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
            DocumentMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
            AudioMessageCellProvider(logger: logger, conversationId: conversationId, client: client),
            HasMoreIndicatorCellProvider(conversationId: conversationId),
        ]
        if let videoCallClient = videoCallClient {
            providers.append(
                VideoCallActionRequestCellProvider(
                    logger: logger,
                    conversationId: conversationId,
                    client: client,
                    videoCallClient: videoCallClient
                )
            )
        }
        return .init(
            showComposer: showComposer,
            logger: logger,
            videoCallClient: videoCallClient,
            providers: providers
        )
    }
}
