import Foundation
import NablaCore
import UIKit

public enum NablaViewFactory {
    public static func createConversationListView(delegate: ConversationListDelegate) -> ConversationListView {
        let view = ConversationListView(frame: .zero)
        let presenter = ConversationListPresenterImpl(
            viewContract: view,
            delegate: delegate,
            client: NablaClient.shared
        )
        view.presenter = presenter
        return view
    }

    public static func createConversationViewController(_ conversation: Conversation) -> UIViewController {
        let viewController = ConversationViewController(
            providers: [
                DateSeparatorCellProvider(),
                EventCellProvider(),
                TextMessageCellProvider(conversationId: conversation.id),
                TypingIndicatorCellProvider(conversationId: conversation.id),
                DeletedMessageCellProvider(conversationId: conversation.id),
                ImageMessageCellProvider(conversationId: conversation.id),
            ]
        )
        viewController.presenter = ConversationPresenterImpl(
            conversation: conversation,
            view: viewController,
            client: NablaClient.shared
        )
        return viewController
    }
}
