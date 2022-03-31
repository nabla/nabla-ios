import Foundation
import UIKit

public class ConversationListView: UIView, ConversationListViewContract {
    // MARK: - Public

    public weak var delegate: ConversationListViewDelegate?

    var presenter: ConversationListPresenter?

    // MARK: - Initializer

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        presenter?.start()
    }

    // MARK: - ConversationListViewContract

    func configure(with viewModel: ConversationListViewModel) {
        self.viewModel = viewModel
        tableView.reload(animated: true)
    }

    // MARK: - Private

    private lazy var tableView: UITableView = createTableView()

    private var viewModel: ConversationListViewModel = .empty

    private func setUp() {
        addSubview(tableView)
        tableView.pinToSuperView()
    }

    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ConversationListItemCell.self)
        tableView.separatorInset = .only(left: 70)
        return tableView
    }
}

extension ConversationListView: UITableViewDataSource {
    // MARK: - UITableViewDataSource

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: ConversationListItemCell.self, for: indexPath)
        cell.configure(with: viewModel.items[indexPath.row])
        return cell
    }
}

extension ConversationListView: UITableViewDelegate {
    // MARK: - UITableViewDelegate

    public func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        // Notify presenter
    }
}
