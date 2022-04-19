import Foundation
import NablaCore
import NablaUIMessaging
import UIKit

protocol Coordinator {}

final class ConversationsCoordinator: Coordinator {
    // MARK: - Internal
    
    func start(animated: Bool) {
        let viewController = InboxViewController()
        let presenter = InboxPresenter(view: viewController, delegate: self)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    // MARK: - Private
    
    private unowned var navigationController: UINavigationController
    
    private func navigateToConversation(_: Conversation) {
        let viewController = NablaViewFactory.createConversationViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ConversationsCoordinator: InboxPresenterDelegate {
    func inboxPresenter(_: InboxPresenter, didCreate conversation: Conversation) {
        navigateToConversation(conversation)
    }
    
    func inboxPresenter(_: InboxPresenter, didSelect conversation: Conversation) {
        navigateToConversation(conversation)
    }
}
