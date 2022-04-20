import Foundation
import NablaCore
import NablaUIMessaging
import UIKit

final class InboxViewController: UIViewController, InboxViewContract {
    // MARK: Init
    
    var presenter: InboxPresenter?
    
    func set(loading: Bool) {
        createConversationButton.isLoading = loading
    }
    
    func display(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
    }
    
    // MARK: Subviews
    
    private lazy var createConversationButton: LoadingButton = {
        let view = LoadingButton()
        view.setImage(.squareAndPencil, for: .normal)
        view.addTarget(self, action: #selector(createConversationButtonHandler), for: .touchUpInside)
        return view
    }()
    
    private func setUpSubviews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: createConversationButton)
        
        let view = NablaViewFactory.createConversationListView(delegate: self)
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
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
