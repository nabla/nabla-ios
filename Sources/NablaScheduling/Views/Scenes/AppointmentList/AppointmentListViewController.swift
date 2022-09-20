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
    
    /// For navigation purposes only.
    private var selectedCategory: Category?
    
    private enum Constants {
        static let headerHeight = CGFloat(63)
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
        let upcomingAction = UIAction(
            title: L10n.appointmentsScreenSelectorUpcomingLabel,
            identifier: .init(rawValue: "Upcoming"),
            handler: { [weak self] _ in
                self?.viewModel.selectedSelector = .upcoming
            }
        )
        let finalizedAction = UIAction(
            title: L10n.appointmentsScreenSelectorFinalizedLabel,
            identifier: .init(rawValue: "Finalized"),
            handler: { [weak self] _ in
                self?.viewModel.selectedSelector = .finalized
            }
        )
        return UISegmentedControl(items: [upcomingAction, finalizedAction])
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.nabla.register(AppointmentCell.self)
        view.delegate = self
        view.separatorStyle = .none
        view.allowsSelection = false
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
        view.title = L10n.appointmentsScreenActionButtonLabel
        view.onTap = { [weak self] in
            self?.viewModel.userDidTapCreateAppointmentButton()
        }
        return view
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.AppointmentListViewTheme.backgroundColor
        
        headerContainer.addSubview(segmentedControl)
        segmentedControl.nabla.pinToSuperView(insets: .nabla.all(16))
        
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
            self.updateSelector()
            self.updateModal()
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
    
    private func updateModal() {
        guard presentedViewController == nil, let modal = viewModel.modal else { return }
        let controller = makeController(modal: modal)
        present(controller, animated: true) { [viewModel] in
            viewModel.modal = nil
        }
    }
    
    // MARK: Modals
    
    private func makeController(modal: AppointmentsViewModal) -> UIViewController {
        switch modal {
        case let .alert(alert):
            return nabla.makeController(for: alert)
        case let .sheet(sheet):
            return nabla.makeController(for: sheet) { [weak self] itemIndex in
                guard let cell = self?.tableView.cellForRow(at: IndexPath(row: itemIndex, section: 0)) as? AppointmentCell else { return nil }
                return cell.secondaryActionsButton
            }
        }
    }
}

extension AppointmentListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.nabla.contentDoesFitFrame, scrollView.nabla.isScrollAtBottom(offset: 50) {
            viewModel.userDidReachEndOfList()
        }
    }
}

extension Appointment: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Appointment, rhs: Appointment) -> Bool {
        lhs.id == rhs.id
    }
}

extension AppointmentListViewController: AppointmentListViewModelDelegate {
    func appointmentListViewModel(_: AppointmentListViewModel, didJoinVideoCall room: Appointment.VideoCallRoom) {
        guard let videoCallClient = videoCallClient else {
            logger.error(message: "Missing `NablaVideoCallModule`.")
            return
        }
        videoCallClient.openVideoCallRoom(url: room.url, token: room.token, from: self)
    }

    func appointmentListViewModelDidSelectNewAppointment(_: AppointmentListViewModel) {
        factory.presentScheduleAppointmentViewController(from: self)
    }
}
