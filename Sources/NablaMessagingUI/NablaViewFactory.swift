import Foundation
import NablaMessagingCore
import UIKit

public enum NablaViewFactory {
    public static func createConversationListView(
        delegate: ConversationListDelegate,
        client: NablaMessagingClient = .shared
    ) -> ConversationListView {
        createConversationListView(
            delegate: delegate,
            client: client as NablaMessagingClientProtocol
        )
    }
  
    public static func createConversationViewController(
        _ conversation: Conversation,
        client: NablaMessagingClient = .shared
    ) -> UIViewController {
        createConversationViewController(
            conversation,
            client: client as NablaMessagingClientProtocol
        )
    }

    // MARK: - Internal

    static func createConversationListView(
        delegate: ConversationListDelegate,
        client: NablaMessagingClientProtocol
    ) -> ConversationListView {
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

    static func createConversationViewController(
        _ conversation: Conversation,
        client: NablaMessagingClientProtocol
    ) -> UIViewController {
        let viewController = ConversationViewController.create(
            conversationId: conversation.id,
            client: client,
            logger: client.logger
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
