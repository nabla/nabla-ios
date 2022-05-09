import Foundation
import NablaMessagingCore
import UIKit

public enum NablaViewFactory {
    public static func createConversationListView(delegate: ConversationListDelegate, client: NablaMessagingClient = .shared) -> ConversationListView {
        let view = ConversationListView(frame: .zero)
        let presenter = ConversationListPresenterImpl(
            viewContract: view,
            delegate: delegate,
            client: client
        )
        view.presenter = presenter
        return view
    }
    
    public static func createConversationViewController(_ conversation: Conversation, client: NablaMessagingClient = .shared) -> UIViewController {
        let viewController = ConversationViewController(
            providers: [
                DateSeparatorCellProvider(),
                EventCellProvider(),
                TextMessageCellProvider(conversationId: conversation.id, client: client),
                TypingIndicatorCellProvider(conversationId: conversation.id, client: client),
                DeletedMessageCellProvider(conversationId: conversation.id, client: client),
                ImageMessageCellProvider(conversationId: conversation.id, client: client),
                DocumentMessageCellProvider(conversationId: conversation.id, client: client),
                HasMoreIndicatorCellProvider(conversationId: conversation.id),
            ]
        )
        viewController.presenter = ConversationPresenterImpl(
            conversation: conversation,
            view: viewController,
            client: client
        )
        return viewController
    }
}
