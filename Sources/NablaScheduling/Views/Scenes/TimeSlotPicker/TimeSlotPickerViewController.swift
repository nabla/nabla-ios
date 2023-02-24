import NablaCore
import UIKit

final class TimeSlotPickerViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(
        viewModel: TimeSlotPickerViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = L10n.timeSlotsScreenTitle
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @ObservedViewModel private var viewModel: TimeSlotPickerViewModel
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        observeViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomContainer.frame.height, right: 0)
    }
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.delegate = self
        view.allowsSelection = true
        view.nabla.register(TimeSlotGroupCell.self)
        view.refreshControl = refreshControl
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
        view.text = L10n.timeSlotsPickerScreenEmptyLabel
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = NablaTheme.CategoryPickerViewTheme.emptyViewTextColor
        view.font = NablaTheme.CategoryPickerViewTheme.emptyViewFont
        return view
    }()
    
    private lazy var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var actionButton: NablaViews.PrimaryButton = {
        let view = NablaViews.PrimaryButton()
        view.theme = NablaTheme.TimeSlotPickerViewTheme.button
        view.setTitle(L10n.timeSlotsScreenActionButtonLabel, for: .normal)
        view.onTap = { [viewModel] in
            viewModel.userDidTapConfirmButton()
        }
        return view
    }()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.TimeSlotPickerViewTheme.backgroundColor
        
        view.addSubview(tableView)
        tableView.nabla.pinToSuperView()
        
        view.addSubview(emptyView)
        emptyView.nabla.pin(to: view.safeAreaLayoutGuide, insets: .nabla.all(32))
        
        view.addSubview(bottomContainer)
        bottomContainer.nabla.pin(to: view.safeAreaLayoutGuide, edges: [.leading, .bottom, .trailing])
        
        bottomContainer.addSubview(actionButton)
        actionButton.nabla.pinToSuperView(insets: .nabla.all(16))
    }
    
    // MARK: DataSource
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, TimeSlotGroupViewItem> = {
        let dataSource = UITableViewDiffableDataSource<Int, TimeSlotGroupViewItem>(tableView: tableView) { [viewModel] tableView, indexPath, group in
            let cell = tableView.nabla.dequeueReusableCell(ofClass: TimeSlotGroupCell.self, for: indexPath)
            cell.title = group.title
            cell.subtitle = group.subtitle
            cell.timeSlots = group.timeSlots
            cell.isOpened = group.opened
            cell.onTapTimeSlot = { timeSlot, index in
                viewModel.userDidTapTimeSlot(timeSlot, at: index, in: group, at: indexPath.row)
            }
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    
    // MARK: ViewModel
    
    private func observeViewModel() {
        _viewModel.onChange(throttle: .milliseconds(100)) { [weak self] _ in
            guard let self = self else { return }
            self.updateLoadingIndicator()
            self.updateItems()
            self.updateActionButton()
            self.updateError()
        }
    }
    
    private func updateLoadingIndicator() {
        if refreshControl.isRefreshing, !viewModel.isLoading {
            refreshControl.endRefreshing()
        }
        if !refreshControl.isRefreshing, viewModel.isLoading {
            refreshControl.nabla.beginRefreshing()
        }
    }
    
    private func updateItems() {
        emptyView.isHidden = !viewModel.groups.isEmpty || viewModel.isLoading
        
        let previousItems = dataSource.snapshot()
        let isFirstLoad = previousItems.numberOfItems == 0 && !viewModel.groups.isEmpty
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, TimeSlotGroupViewItem>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(viewModel.groups, toSection: 0)
        guard snapshot.itemIdentifiers != dataSource.snapshot().itemIdentifiers else { return }
        dataSource.apply(snapshot, animatingDifferences: !isFirstLoad) { [weak self] in
            guard let self = self else { return }
            if self.tableView.nabla.isScrollAtBottom {
                self.viewModel.userDidReachEndOfList()
            }
        }
    }
    
    private func updateActionButton() {
        actionButton.isEnabled = viewModel.canSubmit
        actionButton.isLoading = viewModel.isSubmitting
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

extension TimeSlotPickerViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let group = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.userDidTapGroup(group, at: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.nabla.contentDoesFitFrame, scrollView.nabla.isScrollAtBottom(offset: 50) {
            viewModel.userDidReachEndOfList()
        }
    }
}
