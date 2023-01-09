import Foundation
import NablaCore
import UIKit

public class ConversationListView: UIView, ConversationListViewContract {
    // MARK: - Public

    var presenter: ConversationListPresenter?

    // MARK: - Initializer

    init(logger: Logger) {
        self.logger = logger
        super.init(frame: .zero)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()

        if superview != nil {
            presenter?.start()
        }
    }

    // MARK: - ConversationListViewContract

    func configure(with state: ConversationListViewState) {
        switch state {
        case let .loaded(viewModel):
            updateItems(viewModel: viewModel)
            loadingIndicator.isHidden = true
            errorView.isHidden = true
            if viewModel.items.isEmpty {
                tableView.isHidden = true
                emptyView.isHidden = false
            } else {
                tableView.isHidden = false
                emptyView.isHidden = true
            }
        case let .error(errorViewModel):
            errorView.configure(with: errorViewModel)
            loadingIndicator.isHidden = true
            errorView.isHidden = false
            tableView.isHidden = true
            emptyView.isHidden = true
        case .loading:
            loadingIndicator.isHidden = false
            errorView.isHidden = true
            tableView.isHidden = true
            emptyView.isHidden = true
        }
    }

    func displayLoadingMore() {
        tableView.tableFooterView = loadingFooterView
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)
        tableView.setContentOffset(bottomOffset, animated: true)
    }

    func hideLoadingMore() {
        tableView.tableFooterView = nil
    }

    // MARK: - Private

    private enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ConversationListItemViewModel>
    private typealias DataSource = UITableViewDiffableDataSource<Section, ConversationListItemViewModel>

    private lazy var tableView: UITableView = createTableView()
    private lazy var dataSource = makeDataSource()
    private lazy var emptyView = EmptyView()
    private lazy var loadingIndicator: UIActivityIndicatorView = createLoadingIndicator()
    private lazy var errorView: ErrorView = createErrorView()
    private lazy var loadingFooterView: LoadingFooterView = createLoadingFooterView()

    private let logger: Logger
    private var viewModel: ConversationListViewModel = .empty

    private func setUp() {
        backgroundColor = NablaTheme.ConversationPreview.backgroundColor
        addSubview(tableView)
        tableView.nabla.pinToSuperView()
        addSubview(emptyView)
        emptyView.nabla.pinToSuperView()
        addSubview(loadingIndicator)
        loadingIndicator.nabla.constraintToCenterInSuperView()
        addSubview(errorView)
        errorView.nabla.pinToSuperView()
    }

    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.nabla.register(ConversationListItemCell.self)
        tableView.separatorInset = .nabla.only(left: 70)
        tableView.backgroundColor = NablaTheme.ConversationPreview.backgroundColor
        return tableView
    }

    private func createLoadingIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.startAnimating()
        return view
    }

    private func createErrorView() -> ErrorView {
        let view = ErrorView()
        view.delegate = self
        return view
    }

    private func createLoadingFooterView() -> LoadingFooterView {
        let footerView = LoadingFooterView()
        footerView.sizeToFit()
        return footerView
    }

    private func makeDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.nabla.dequeueReusableCell(ofClass: ConversationListItemCell.self, for: indexPath)
            cell.configure(with: item)
            return cell
        }
    }

    private func updateItems(viewModel: ConversationListViewModel) {
        let oldItems = self.viewModel.items
        let animated = !oldItems.isEmpty
        self.viewModel = viewModel
        let snapshot = applySnapshot(
            items: viewModel.items,
            animatingDifferences: animated,
            completion: { self.hideLoadingMore() }
        )
        reconfigureItems(
            snapshot: snapshot,
            oldItems: oldItems,
            newItems: self.viewModel.items,
            animatingDifferences: animated
        )
    }

    private func reconfigureItems(
        snapshot: Snapshot,
        oldItems: [ConversationListItemViewModel],
        newItems: [ConversationListItemViewModel],
        animatingDifferences: Bool
    ) {
        var snapshot = snapshot
        let oldItemsMap = Dictionary(grouping: oldItems, by: { $0.id })
        let itemsToReload = newItems.compactMap { newItem -> ConversationListItemViewModel? in
            guard let oldItem = oldItemsMap[newItem.id]?.first else { return nil }
            guard oldItem.hasChanged(otherItem: newItem) else { return nil }
            return newItem
        }
        snapshot.reloadItems(itemsToReload)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func applySnapshot(
        items: [ConversationListItemViewModel],
        animatingDifferences: Bool,
        completion: @escaping (() -> Void)
    ) -> Snapshot {
        var seen = Set<UUID>()
        let items = items.compactMap { item -> ConversationListItemViewModel? in
            guard !seen.contains(item.id) else {
                logger.error(message: "Found duplicated item in Conversation list items", extra: ["id": item.id])
                return nil
            }
            seen.insert(item.id)
            return item
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)

        return snapshot
    }
}

extension ConversationListView: UITableViewDelegate {
    // MARK: - UITableViewDelegate

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Notify presenter
        presenter?.didSelectConversation(at: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height * 0.9 {
            presenter?.didScrollToBottom()
        }
    }
}

extension ConversationListView: ErrorViewDelegate {
    // MARK: - ErrorViewDelegate

    func errorViewDidTapButton(_: ErrorView) {
        presenter?.didTapRetry()
    }
}
