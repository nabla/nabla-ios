import NablaCore
import NablaUtils
import UIKit

public class ViewController: UIViewController {
    // MARK: Init

    public init() {
        // Temporary example, move elsewhere for "real" instances
        Resolver.shared.register(type: NablaUtils.self, NablaUtils())

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let view = NablaViewFactory().createConversationListView(delegate: self)
        self.view.addSubview(view)
        view.pinToSuperView()
    }
}

extension ViewController: ConversationListViewDelegate {
    // MARK: - ConversationListViewDelegate
}
