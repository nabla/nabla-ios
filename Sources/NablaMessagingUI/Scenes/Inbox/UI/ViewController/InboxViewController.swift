import Foundation
import NablaMessagingCore
import UIKit

final class InboxViewController: UIViewController, InboxViewContract {
    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }

    // MARK: - Public

    var presenter: InboxPresenter?

    func setContentView(_ innerView: UIView) {
        view.addSubview(innerView)
        innerView.pinToSuperView()
    }

    // MARK: - InboxViewContract

    func set(loading: Bool) {
        createConversationButton.isLoading = loading
    }

    func display(error: String) {
        let alert = UIAlertController(title: L10n.inboxErrorAlertTitle, message: error, preferredStyle: .alert)
        alert.addAction(.init(title: L10n.inboxErrorAlertCancelActionTitle, style: .cancel))
        present(alert, animated: true)
    }

    // MARK: Private

    private lazy var createConversationButton: LoadingButton = {
        let view = LoadingButton()
        view.setImage(NablaTheme.ConversationPreview.createConversationIcon, for: .normal)
        view.addTarget(self, action: #selector(createConversationButtonHandler), for: .touchUpInside)
        view.tintColor = NablaTheme.ConversationPreview.createConversationColor
        return view
    }()

    private func setUp() {
        title = L10n.inboxTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: createConversationButton)
    }

    // MARK: Handlers

    @objc private func createConversationButtonHandler() {
        presenter?.userDidTapCreateConversation()
    }
}

extension InboxViewController: ConversationListDelegate {
    // MARK: - ConversationListDelegate

    func conversationList(didSelect conversation: Conversation) {
        presenter?.userDidSelectConversation(conversation)
    }
}
