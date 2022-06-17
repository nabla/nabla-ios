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

    public static func createInboxViewController(
        delegate: InboxDelegate,
        client: NablaMessagingClient = .shared
    ) -> UIViewController {
        createInboxViewController(
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
    
    public static func createConversationViewController(
        _ conversationId: UUID,
        client: NablaMessagingClient = .shared
    ) -> UIViewController {
        createConversationViewController(
            conversationId,
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

    static func createInboxViewController(
        delegate: InboxDelegate,
        client: NablaMessagingClientProtocol
    ) -> InboxViewController {
        let viewController = InboxViewController()
        let view = createConversationListView(delegate: viewController, client: client)
        viewController.setContentView(view)
        let presenter = InboxPresenterImpl(
            logger: client.logger,
            viewContract: viewController,
            delegate: delegate,
            client: client
        )
        viewController.presenter = presenter
        return viewController
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
    
    static func createConversationViewController(
        _ conversationId: UUID,
        client: NablaMessagingClientProtocol
    ) -> UIViewController {
        let viewController = ConversationViewController.create(
            conversationId: conversationId,
            client: client,
            logger: client.logger
        )
        viewController.presenter = ConversationPresenterImpl(
            logger: client.logger,
            conversationId: conversationId,
            view: viewController,
            client: client
        )
        return viewController
    }
}
