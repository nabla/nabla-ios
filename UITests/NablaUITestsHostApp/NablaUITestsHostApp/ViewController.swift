import NablaMessagingCore
@testable import NablaMessagingUI
import UIKit

final class ViewController: UIViewController {
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: createConversationButton)

        let view = NablaViewFactory.createConversationListView(
            delegate: self,
            client: NablaMessagingClientProtocolMock.shared
        )
        setContentView(view)
    }
    
    // MARK: - Private

    private var createConversationAction: Any?

    // MARK: Handlers

    @objc func createConversationButtonHandler() {
        createConversationAction = NablaMessagingClientProtocolMock.shared.createConversation { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(conversation):
                let destination = NablaViewFactory.createConversationViewController(conversation)
                self.navigationController?.pushViewController(destination, animated: true)
            }
        }
    }

    // MARK: - Private

    private lazy var createConversationButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        view.addTarget(self, action: #selector(createConversationButtonHandler), for: .touchUpInside)
        return view
    }()

    private func setContentView(_ contentView: UIView) {
        view.subviews.forEach { $0.removeFromSuperview() }
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ViewController: ConversationListDelegate {
    func conversationList(didSelect conversation: Conversation) {
        let destination = NablaViewFactory.createConversationViewController(
            conversation,
            client: NablaMessagingClientProtocolMock.shared
        )
        navigationController?.pushViewController(destination, animated: true)
    }
}
