import NablaCore
import UIKit

final class CategoryPickerViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(
        viewModel: CategoryPickerViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = L10n.categoryPickerScreenTitle
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @ObservedViewModel private var viewModel: CategoryPickerViewModel
    
    // MARK: Life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        observeViewModel()
    }
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        view.refreshControl = refreshControl
        view.delegate = self
        view.nabla.register(CategoryCell.self)
        view.nabla.register(DisclaimerCell.self)
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.addTarget(self, action: #selector(refreshControlHandler), for: .valueChanged)
        return view
    }()
    
    private lazy var emptyView: UIView = {
        let view = UILabel()
        view.text = L10n.categoryPickerScreenEmptyLabel
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = NablaTheme.CategoryPickerViewTheme.emptyViewTextColor
        view.font = NablaTheme.CategoryPickerViewTheme.emptyViewFont
        return view
    }()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.CategoryPickerViewTheme.backgroundColor
        
        view.addSubview(tableView)
        tableView.nabla.pinToSuperView()
        
        view.addSubview(emptyView)
        emptyView.nabla.pin(to: view.safeAreaLayoutGuide, insets: .nabla.all(32))
    }
    
    // MARK: DataSource
    
    private enum Section: Int {
        case disclaimer
        case items
    }
    
    fileprivate enum Item {
        case disclaimer(String)
        case category(CategoryViewItem)
    }
    
    private lazy var dataSource: UITableViewDiffableDataSource<Section, Item> = {
        let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { [viewModel] tableView, indexPath, item in
            switch item {
            case let .disclaimer(disclaimer):
                let cell = tableView.nabla.dequeueReusableCell(ofClass: DisclaimerCell.self, for: indexPath)
                cell.text = disclaimer
                return cell
            case let .category(category):
                let cell = tableView.nabla.dequeueReusableCell(ofClass: CategoryCell.self, for: indexPath)
                Self.configure(cell: cell, for: category)
                return cell
            }
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    
    private static func configure(cell: CategoryCell, for item: CategoryViewItem) {
        cell.text = item.title
    }
    
    // MARK: ViewModel
    
    private func observeViewModel() {
        _viewModel.onChange(throttle: .milliseconds(100)) { [weak self] _ in
            guard let self = self else { return }
            self.updateLoadingIndicator()
            self.updateItems()
            self.updateError()
        }
    }
    
    private func updateItems() {
        emptyView.isHidden = !viewModel.items.isEmpty || viewModel.isLoading
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        if let disclaimer = viewModel.disclaimer {
            snapshot.appendSections([.disclaimer])
            snapshot.appendItems([.disclaimer(disclaimer)], toSection: .disclaimer)
        }
        snapshot.appendSections([.items])
        snapshot.appendItems(viewModel.items.map { .category($0) }, toSection: .items)
        guard snapshot.itemIdentifiers != dataSource.snapshot().itemIdentifiers else { return }
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    private func updateLoadingIndicator() {
        if refreshControl.isRefreshing, !viewModel.isLoading {
            refreshControl.endRefreshing()
        }
        if !refreshControl.isRefreshing, viewModel.isLoading {
            refreshControl.nabla.beginRefreshing()
        }
    }
    
    private func updateError() {
        guard presentedViewController == nil, let error = viewModel.error else { return }
        let controller = nabla.makeController(for: error)
        present(controller, animated: true) { [viewModel] in
            viewModel.error = nil
        }
    }
    
    // MARK: Handlers
    
    @objc private func refreshControlHandler() {
        viewModel.userDidPullToRefresh()
    }
}

extension CategoryPickerViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .disclaimer: return
        case let .category(category): viewModel.userDidSelect(category: category, at: indexPath.row)
        }
    }
}

extension CategoryPickerViewController.Item: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.disclaimer(lhs), .disclaimer(rhs)): return lhs == rhs
        case let (.category(lhs), .category(rhs)): return lhs == rhs
        default: return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .disclaimer(disclaimer):
            hasher.combine(disclaimer)
        case let .category(category):
            category.hash(into: &hasher)
        }
    }
}

extension CategoryViewItem: Hashable {
    static func == (lhs: CategoryViewItem, rhs: CategoryViewItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
