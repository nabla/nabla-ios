import Foundation
import NablaCore
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
        showComposer: Bool = true,
        client: NablaMessagingClient = .shared
    ) -> UIViewController {
        createConversationViewController(
            conversation,
            showComposer: showComposer,
            client: client as NablaMessagingClientProtocol
        )
    }
    
    public static func createConversationViewController(
        _ conversationId: UUID,
        showComposer: Bool = true,
        client: NablaMessagingClient = .shared
    ) -> UIViewController {
        createConversationViewController(
            conversationId,
            showComposer: showComposer,
            client: client as NablaMessagingClientProtocol
        )
    }

    // MARK: - Internal

    static func createConversationListView(
        delegate: ConversationListDelegate,
        client: NablaMessagingClientProtocol
    ) -> ConversationListView {
        prepare(client: client)
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
        prepare(client: client)
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
        showComposer: Bool,
        client: NablaMessagingClientProtocol
    ) -> UIViewController {
        prepare(client: client)
        let viewController = ConversationViewController.create(
            conversationId: conversation.id,
            showComposer: showComposer,
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
        showComposer: Bool,
        client: NablaMessagingClientProtocol
    ) -> UIViewController {
        prepare(client: client)
        let viewController = ConversationViewController.create(
            conversationId: conversationId,
            showComposer: showComposer,
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
    
    // MARK: - Private
    
    private static func prepare(client: NablaMessagingClientProtocol) {
        client.addRefetchTriggers(
            NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)
        )
    }
}
