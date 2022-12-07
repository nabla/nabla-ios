import NablaCore
import NablaMessagingCore
@testable import NablaMessagingUI
import UIKit

final class ViewController: UIViewController {
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: createConversationButton)

        let view = NablaMessagingClientProtocolMock.shared.views.createConversationListView(delegate: self)
        setContentView(view)
    }
    
    // MARK: - Private

    private var createConversationAction: Any?

    // MARK: Handlers
    
    @objc func createConversationButtonHandler() {
        let conversation = NablaMessagingClientProtocolMock.shared.startConversation()
        let destination = NablaMessagingClientProtocolMock.shared.views.createConversationViewController(conversation)
        navigationController?.pushViewController(destination, animated: true)
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
        contentView.nabla.pinToSuperView()
    }
}

extension ViewController: ConversationListDelegate {
    func conversationList(didSelect conversation: Conversation) {
        let destination = NablaMessagingClientProtocolMock.shared.views.createConversationViewController(
            conversation
        )
        navigationController?.pushViewController(destination, animated: true)
    }
}
