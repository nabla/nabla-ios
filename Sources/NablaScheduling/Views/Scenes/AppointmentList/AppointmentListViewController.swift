import NablaCore
import UIKit

final class AppointmentListViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(
        viewModel: AppointmentListViewModel,
        factory: NablaSchedulingViewFactory & InternalSchedulingViewFactory,
        logger: Logger,
        videoCallClient: VideoCallClient?
    ) {
        self.viewModel = viewModel
        self.factory = factory
        self.logger = logger
        self.videoCallClient = videoCallClient
        super.init(nibName: nil, bundle: nil)
        title = L10n.appointmentsScreenTitle
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let factory: NablaSchedulingViewFactory & InternalSchedulingViewFactory
    private let logger: Logger
    private let videoCallClient: VideoCallClient?
    
    @ObservedViewModel private var viewModel: AppointmentListViewModel
    
    private enum Constants {
        static let headerHeight = CGFloat(47)
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        observeViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = .init(
            top: 0,
            left: 0,
            bottom: bottomContainer.frame.height,
            right: 0
        )
        /// According to documentation, `tableHeaderView` must be manually updated.
        tableView.tableHeaderView?.frame.size.height = Constants.headerHeight
    }
    
    // MARK: Subviews
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [
            L10n.appointmentsScreenSelectorUpcomingLabel,
            L10n.appointmentsScreenSelectorFinalizedLabel,
        ])
        control.addTarget(self, action: #selector(segmentedControlValueChangedHandler), for: .valueChanged)
        return control
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.nabla.register(AppointmentCell.self)
        view.delegate = self
        view.separatorStyle = .none
        view.allowsSelection = true
        view.backgroundColor = .clear
        view.estimatedRowHeight = 78
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    private lazy var emptyView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = NablaTheme.AppointmentListViewTheme.emptyViewTextColor
        view.font = NablaTheme.AppointmentListViewTheme.emptyViewFont
        return view
    }()
    
    private lazy var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var actionButton: UIControl = {
        let view = NablaViews.PrimaryButton()
        view.theme = NablaTheme.AppointmentListViewTheme.button
        view.setTitle(L10n.appointmentsScreenActionButtonLabel, for: .normal)
        view.onTap = { [weak self] in
            self?.viewModel.userDidTapCreateAppointmentButton()
        }
        return view
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.startAnimating()
        return view
    }()
    
    private lazy var refreshingIndicatorView = NablaViews.RefreshingIndicatorView()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.AppointmentListViewTheme.backgroundColor
        
        headerContainer.addSubview(segmentedControl)
        segmentedControl.nabla.pinToSuperView(insets: .init(top: 16, leading: 16, bottom: 0, trailing: 16))
        
        view.addSubview(tableView)
        tableView.nabla.pin(to: view.safeAreaLayoutGuide)
        
        tableView.tableHeaderView = headerContainer
        headerContainer.nabla.constraintHeight(Constants.headerHeight)
        NSLayoutConstraint.activate([
            headerContainer.widthAnchor.constraint(equalTo: tableView.widthAnchor),
        ])
        
        view.addSubview(emptyView)
        emptyView.nabla.pin(to: view.safeAreaLayoutGuide, insets: .nabla.all(32))
        
        view.addSubview(loadingView)
        loadingView.nabla.constraintToCenterInSuperView()
        
        view.addSubview(bottomContainer)
        bottomContainer.nabla.pin(to: view.safeAreaLayoutGuide, edges: [.leading, .bottom, .trailing])
        
        bottomContainer.addSubview(actionButton)
        actionButton.nabla.pinToSuperView(insets: .nabla.all(16))
    }
    
    // MARK: Handlers
    
    @objc private func segmentedControlValueChangedHandler(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: viewModel.selectedSelector = .upcoming
        case 1: viewModel.selectedSelector = .finalized
        default: logger.error(
                message: "Unknown selectedSegmentIndex",
                extra: ["selectedSegmentIndex": sender.selectedSegmentIndex]
            )
        }
    }
    
    // MARK: DataSource
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, Appointment> = {
        let dataSource = UITableViewDiffableDataSource<Int, Appointment>(tableView: tableView) { [viewModel, factory] tableView, indexPath, appointment in
            let cell = tableView.nabla.dequeueReusableCell(ofClass: AppointmentCell.self, for: indexPath)
            cell.viewModel = factory.createAppointmentCellViewModel(appointment: appointment, delegate: viewModel)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    
    // MARK: ViewModel
    
    private func observeViewModel() {
        _viewModel.onChange(throttle: .milliseconds(100)) { [weak self] _ in
            guard let self = self else { return }
            self.updateAppointmentList()
            self.updateIsLoading()
            self.updateIsRefreshing()
            self.updateSelector()
            self.updateAlert()
            self.updateVideoCallRoom()
            self.updateExternalCallURL()
        }
    }
    
    private func updateAppointmentList() {
        emptyView.isHidden = !viewModel.appointments.isEmpty || viewModel.isLoading
        
        let previousItems = dataSource.snapshot()
        let isFirstLoad = previousItems.numberOfItems == 0 && !viewModel.appointments.isEmpty
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Appointment>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.appointments, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: !isFirstLoad) { [weak self] in
            guard isFirstLoad, let self = self else { return }
            if self.tableView.nabla.isScrollAtBottom {
                self.viewModel.userDidReachEndOfList()
            }
        }
    }
    
    private func updateSelector() {
        segmentedControl.selectedSegmentIndex = viewModel.selectedSelector.rawValue
        switch viewModel.selectedSelector {
        case .upcoming:
            emptyView.text = L10n.appointmentsScreenUpcomingEmptyLabel
        case .finalized:
            emptyView.text = L10n.appointmentsScreenFinalizedEmptyLabel
        }
    }
    
    private func updateIsLoading() {
        loadingView.isHidden = !viewModel.isLoading
    }
    
    private var defaultTitleView: UIView?
    private func updateIsRefreshing() {
        if viewModel.isRefreshing {
            defaultTitleView = navigationItem.titleView
            navigationItem.titleView = refreshingIndicatorView
        } else {
            navigationItem.titleView = defaultTitleView
            defaultTitleView = nil
        }
    }
    
    private func updateAlert() {
        guard presentedViewController == nil, let alert = viewModel.alert else { return }
        let controller = nabla.makeController(for: alert)
        present(controller, animated: true) { [viewModel] in
            viewModel.alert = nil
        }
    }
    
    private func updateVideoCallRoom() {
        guard let room = viewModel.videoCallRoom else { return }
        guard let videoCallClient = videoCallClient else {
            logger.error(message: "Missing `NablaVideoCallModule`.")
            return
        }
        videoCallClient.openVideoCallRoom(url: room.url, token: room.token, from: self)
    }

    private func updateExternalCallURL() {
        guard let externalCallURL = viewModel.externalCallURL else { return }
        UIApplication.shared.open(externalCallURL) { _ in
            self.viewModel.externalCallURL = nil
        }
    }
}

extension AppointmentListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.nabla.contentDoesFitFrame, scrollView.nabla.isScrollAtBottom(offset: 50) {
            viewModel.userDidReachEndOfList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userDidSelectAppointment(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension Appointment: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Appointment, rhs: Appointment) -> Bool {
        lhs.id == rhs.id
    }
}
