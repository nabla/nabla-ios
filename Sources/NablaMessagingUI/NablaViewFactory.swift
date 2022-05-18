import Foundation
import NablaMessagingCore
import UIKit

public enum NablaViewFactory {
    public static func createConversationListView(delegate: ConversationListDelegate, client: NablaMessagingClient = .shared) -> ConversationListView {
        let view = ConversationListView(frame: .zero)
        let presenter = ConversationListPresenterImpl(
            logger: client.logger,
            viewContract: view,
            delegate: delegate,
            client: client
        )
        view.presenter = presenter
        return view
    }
    
    public static func createConversationViewController(_ conversation: Conversation, client: NablaMessagingClient = .shared) -> UIViewController {
        let viewController = ConversationViewController(
            logger: client.logger,
            providers: [
                DateSeparatorCellProvider(),
                EventCellProvider(),
                TextMessageCellProvider(logger: client.logger, conversationId: conversation.id, client: client),
                TypingIndicatorCellProvider(logger: client.logger, conversationId: conversation.id, client: client),
                DeletedMessageCellProvider(logger: client.logger, conversationId: conversation.id, client: client),
                ImageMessageCellProvider(logger: client.logger, conversationId: conversation.id, client: client),
                DocumentMessageCellProvider(logger: client.logger, conversationId: conversation.id, client: client),
                HasMoreIndicatorCellProvider(conversationId: conversation.id),
            ]
        )
        viewController.presenter = ConversationPresenterImpl(
            logger: client.logger,
            conversation: conversation,
            view: viewController,
            client: client
        )
        return viewController
    }
}
