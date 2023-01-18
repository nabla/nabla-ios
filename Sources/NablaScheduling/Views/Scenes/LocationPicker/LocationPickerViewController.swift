import NablaCore
import UIKit

final class LocationPickerViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(
        viewModel: LocationPickerViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = L10n.locationPickerScreenTitle
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @ObservedViewModel private var viewModel: LocationPickerViewModel
    
    // MARK: Life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        observeViewModel()
        viewModel.start()
    }
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        view.refreshControl = refreshControl
        view.delegate = self
        view.nabla.register(LocationCell.self)
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
        view.text = L10n.locationPickerScreenEmptyLabel
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = NablaTheme.LocationPickerViewTheme.emptyViewTextColor
        view.font = NablaTheme.LocationPickerViewTheme.emptyViewFont
        return view
    }()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.LocationPickerViewTheme.backgroundColor
        
        view.addSubview(tableView)
        tableView.nabla.pinToSuperView()
        
        view.addSubview(emptyView)
        emptyView.nabla.pin(to: view.safeAreaLayoutGuide, insets: .nabla.all(32))
    }
    
    // MARK: DataSource
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, LocationViewItem> = {
        let dataSource = UITableViewDiffableDataSource<Int, LocationViewItem>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.nabla.dequeueReusableCell(ofClass: LocationCell.self, for: indexPath)
            Self.configure(cell: cell, for: item)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    
    private static func configure(cell: LocationCell, for item: LocationViewItem) {
        cell.icon = item.icon
        cell.text = item.name
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, LocationViewItem>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(viewModel.items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    private func updateLoadingIndicator() {
        if refreshControl.isRefreshing, !viewModel.isLoading {
            refreshControl.endRefreshing()
        }
        if !refreshControl.isRefreshing, viewModel.isLoading {
            refreshControl.beginRefreshing()
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

extension LocationPickerViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.userDidSelect(location: item, at: indexPath.row)
    }
}

extension LocationViewItem: Hashable {
    static func == (lhs: LocationViewItem, rhs: LocationViewItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
