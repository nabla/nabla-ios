import Foundation
import NablaUIMessaging
import UIKit

final class InboxViewController: UIViewController {
    // MARK: Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let view = NablaViewFactory.createConversationListView(delegate: self)
        self.view.addSubview(view)
        view.pinToSuperView()
    }
}

extension InboxViewController: ConversationListDelegate {
    func conversationList(didSelectConversationWithId _: UUID) {
        navigationController?.pushViewController(NablaViewFactory.createConversationViewController(), animated: true)
    }
}
