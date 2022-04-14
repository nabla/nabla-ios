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
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

extension InboxViewController: ConversationListDelegate {
    func conversationList(didSelectConversationWithId _: UUID) {
        navigationController?.pushViewController(NablaViewFactory.createConversationViewController(), animated: true)
    }
}
