import Combine
import Foundation
import NablaCore

public protocol AppointmentListDelegate: AnyObject {
    func appointmentListDidSelectAppointment(_ appointment: Appointment)
    func appointmentListDidSelectNewAppointment()
}

enum AppointmentsSelector: Int {
    case upcoming = 0
    case finalized = 1
}

struct AppointmentViewItem {
    let id: UUID
    let avatar: AvatarViewModel
    let title: String
    let date: Date
    let enabled: Bool
    let primaryAction: Action?
    let secondaryAction: (() -> Void)?
    
    struct Action {
        let label: String
        let handler: () -> Void
    }
}

// sourcery: AutoMockable
protocol AppointmentListViewModel: ViewModel, AppointmentCellViewModelDelegate {
    @MainActor var selectedSelector: AppointmentsSelector { get set }
    @MainActor var appointments: [Appointment] { get }
    @MainActor var isLoading: Bool { get }
    @MainActor var isRefreshing: Bool { get }
    @MainActor var alert: AlertViewModel? { get set }
    @MainActor var videoCallRoom: Location.RemoteLocation.VideoCallRoom? { get }
    
    @MainActor func userDidReachEndOfList()
    @MainActor func userDidTapCreateAppointmentButton()
    @MainActor func userDidSelectAppointment(atIndex index: Int)
}

@MainActor
final class AppointmentListViewModelImpl: AppointmentListViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: AppointmentListDelegate?
    
    @Published var selectedSelector: AppointmentsSelector = .upcoming
    @Published var alert: AlertViewModel?
    @Published var videoCallRoom: Location.RemoteLocation.VideoCallRoom?
    
    var isLoading: Bool {
        switch selectedSelector {
        case .upcoming: return isLoadingUpcomingAppointments
        case .finalized: return isLoadingFinalizedAppointments
        }
    }
    
    var isRefreshing: Bool {
        switch selectedSelector {
        case .upcoming: return isRefreshingUpcomingAppointments
        case .finalized: return isRefreshingFinalizedAppointments
        }
    }
    
    var appointments: [Appointment] {
        switch selectedSelector {
        case .upcoming: return upcomingAppointments.elements
        case .finalized: return finalizedAppointments.elements
        }
    }
    
    func userDidReachEndOfList() {
        Task {
            await loadMoreAppointments()
        }
    }
    
    func userDidTapCreateAppointmentButton() {
        delegate?.appointmentListDidSelectNewAppointment()
    }
    
    func userDidSelectAppointment(atIndex index: Int) {
        let appointment: Appointment?
        switch selectedSelector {
        case .upcoming: appointment = upcomingAppointments.elements.nabla.element(at: index)
        case .finalized: appointment = finalizedAppointments.elements.nabla.element(at: index)
        }
        guard let selectedAppointment = appointment else {
            logger.error(message: "Appointment at index not found", extra: ["index": index])
            return
        }
        delegate?.appointmentListDidSelectAppointment(selectedAppointment)
    }
    
    // MARK: Init
    
    nonisolated init(
        delegate: AppointmentListDelegate,
        client: NablaSchedulingClient,
        logger: Logger
    ) {
        self.delegate = delegate
        self.client = client
        self.logger = logger
        
        Task {
            await watchUpcomingAppointments()
            await watchFinalizedAppointments()
        }
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let preAppointmentPeriod = TimeInterval(15 * 60)
    }
    
    private let client: NablaSchedulingClient
    private let logger: Logger
    
    @Published private var upcomingAppointments: PaginatedList<Appointment> = .empty
    @Published private var finalizedAppointments: PaginatedList<Appointment> = .empty
    @Published private var isLoadingUpcomingAppointments = false
    @Published private var isLoadingFinalizedAppointments = false
    @Published private var isRefreshingUpcomingAppointments = false
    @Published private var isRefreshingFinalizedAppointments = false
    
    private var isLoadingMoreUpcomingAppointments = false
    private var isLoadingMoreFinalizedAppointments = false
    
    private var upcomingAppointmentsWatcher: AnyCancellable?
    private var finalizedAppointmentsWatcher: AnyCancellable?
    
    private func watchUpcomingAppointments() {
        isLoadingUpcomingAppointments = true
        
        upcomingAppointmentsWatcher = client.watchAppointments(state: .upcoming)
            .nabla.drive(
                receiveValue: { [weak self] response in
                    self?.upcomingAppointments = response.data
                    self?.isLoadingUpcomingAppointments = false
                    self?.isRefreshingUpcomingAppointments = response.refreshingState.isRefreshing
                },
                receiveError: { [weak self] error in
                    self?.alert = .error(
                        title: L10n.appointmentsScreenLoadListErrorTitle,
                        error: error,
                        fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
                    )
                    self?.isLoadingUpcomingAppointments = false
                    self?.isRefreshingUpcomingAppointments = false
                }
            )
    }
    
    private func watchFinalizedAppointments() {
        isLoadingFinalizedAppointments = true
        
        finalizedAppointmentsWatcher = client.watchAppointments(state: .finalized)
            .nabla.drive(
                receiveValue: { [weak self] response in
                    self?.finalizedAppointments = response.data
                    self?.isLoadingFinalizedAppointments = false
                    self?.isRefreshingFinalizedAppointments = response.refreshingState.isRefreshing
                },
                receiveError: { [weak self] error in
                    self?.alert = .error(
                        title: L10n.appointmentsScreenLoadListErrorTitle,
                        error: error,
                        fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
                    )
                    self?.isLoadingFinalizedAppointments = false
                    self?.isRefreshingFinalizedAppointments = false
                }
            )
    }
    
    private func loadMoreAppointments() async {
        do {
            switch selectedSelector {
            case .upcoming:
                guard !isLoadingMoreUpcomingAppointments else { return }
                isLoadingMoreUpcomingAppointments = true
                try await upcomingAppointments.loadMore?()
            case .finalized:
                guard !isLoadingMoreFinalizedAppointments else { return }
                isLoadingMoreFinalizedAppointments = true
                try await finalizedAppointments.loadMore?()
            }
        } catch {
            alert = .error(
                title: L10n.appointmentsScreenLoadListErrorTitle,
                error: error,
                fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
            )
        }
        switch selectedSelector {
        case .upcoming:
            isLoadingMoreUpcomingAppointments = false
        case .finalized:
            isLoadingMoreFinalizedAppointments = false
        }
    }
}

extension AppointmentListViewModelImpl: AppointmentCellViewModelDelegate {
    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapJoinVideoCall room: Location.RemoteLocation.VideoCallRoom) {
        videoCallRoom = room
    }
    
    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapSecondaryActionsButtonFor appointment: Appointment) {
        delegate?.appointmentListDidSelectAppointment(appointment)
    }
}
