import Foundation
import NablaCore
import NablaMessagingCore
import UIKit

@MainActor public class NablaMessagingViewFactory {
    // MARK: - Public
    
    public func createConversationListView(
        delegate: ConversationListDelegate
    ) -> ConversationListView {
        let view = ConversationListView(logger: logger)
        let presenter = ConversationListPresenterImpl(
            logger: logger,
            viewContract: view,
            delegate: delegate,
            client: client
        )
        view.presenter = presenter
        return view
    }

    public func createInboxViewController(
        delegate: InboxDelegate
    ) -> UIViewController {
        let viewController = InboxViewController()
        let view = createConversationListView(delegate: viewController)
        viewController.setContentView(view)
        let presenter = InboxPresenterImpl(
            logger: logger,
            viewContract: viewController,
            delegate: delegate,
            client: client
        )
        viewController.presenter = presenter
        return viewController
    }
  
    public func createConversationViewController(
        _ conversation: Conversation,
        delegate: ConversationViewControllerDelegate? = nil
    ) -> UIViewController {
        let viewController = ConversationViewController.create(
            conversationId: conversation.id,
            client: client,
            logger: logger,
            videoCallClient: videoCallClient,
            delegate: delegate
        )
        viewController.presenter = ConversationPresenterImpl(
            logger: logger,
            conversation: conversation,
            view: viewController,
            client: client
        )
        return viewController
    }
    
    public func createConversationViewController(
        _ conversationId: UUID,
        delegate: ConversationViewControllerDelegate? = nil
    ) -> UIViewController {
        let viewController = ConversationViewController.create(
            conversationId: conversationId,
            client: client,
            logger: logger,
            videoCallClient: videoCallClient,
            delegate: delegate
        )
        viewController.presenter = ConversationPresenterImpl(
            logger: logger,
            conversationId: conversationId,
            view: viewController,
            client: client
        )
        return viewController
    }
    
    // MARK: - Internal
    
    init(
        client: NablaMessagingClientProtocol,
        logger: Logger,
        videoCallClient: VideoCallClient?
    ) {
        self.client = client
        self.logger = logger
        self.videoCallClient = videoCallClient
        prepare(client: client)
    }
    
    convenience init(client: NablaMessagingClient) {
        self.init(
            client: client,
            logger: client.container.logger,
            videoCallClient: client.container.coreContainer.videoCallClient
        )
    }
    
    // MARK: - Private
    
    private let client: NablaMessagingClientProtocol
    private let logger: Logger
    private let videoCallClient: VideoCallClient?
    
    private func prepare(client: NablaMessagingClientProtocol) {
        client.addRefetchTriggers(
            NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)
        )
    }
}
