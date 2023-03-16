import Combine
import Foundation
import NablaCore

public protocol AppointmentListDelegate: AnyObject {
    @MainActor func appointmentListDidSelectAppointment(_ appointment: Appointment)
    @MainActor func appointmentListDidSelectNewAppointment()
}

enum AppointmentsSelector: Int {
    case scheduled = 0
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
    @MainActor var videoCallRoom: Location.RemoteLocation.VideoCallRoom? { get set }
    @MainActor var externalCallURL: URL? { get set }

    @MainActor func userDidReachEndOfList()
    @MainActor func userDidTapCreateAppointmentButton()
    @MainActor func userDidSelectAppointment(atIndex index: Int)
}

@MainActor
final class AppointmentListViewModelImpl: AppointmentListViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: AppointmentListDelegate?
    
    @Published var selectedSelector: AppointmentsSelector = .scheduled
    @Published var alert: AlertViewModel?
    @Published var videoCallRoom: Location.RemoteLocation.VideoCallRoom?
    @Published var externalCallURL: URL?

    var isLoading: Bool {
        switch selectedSelector {
        case .scheduled: return isLoadingScheduledAppointments
        case .finalized: return isLoadingFinalizedAppointments
        }
    }
    
    var isRefreshing: Bool {
        switch selectedSelector {
        case .scheduled: return isRefreshingScheduledAppointments
        case .finalized: return isRefreshingFinalizedAppointments
        }
    }
    
    var appointments: [Appointment] {
        switch selectedSelector {
        case .scheduled: return scheduledAppointments.elements
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
        case .scheduled: appointment = scheduledAppointments.elements.nabla.element(at: index)
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
            await watchScheduledAppointments()
            await watchFinalizedAppointments()
        }
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let preAppointmentPeriod = TimeInterval(15 * 60)
    }
    
    private let client: NablaSchedulingClient
    private let logger: Logger
    
    @Published private var scheduledAppointments: PaginatedList<Appointment> = .empty
    @Published private var finalizedAppointments: PaginatedList<Appointment> = .empty
    @Published private var isLoadingScheduledAppointments = false
    @Published private var isLoadingFinalizedAppointments = false
    @Published private var isRefreshingScheduledAppointments = false
    @Published private var isRefreshingFinalizedAppointments = false
    
    private var isLoadingMoreScheduledAppointments = false
    private var isLoadingMoreFinalizedAppointments = false
    
    private var scheduledAppointmentsWatcher: AnyCancellable?
    private var finalizedAppointmentsWatcher: AnyCancellable?
    
    private func watchScheduledAppointments() {
        isLoadingScheduledAppointments = true
        
        scheduledAppointmentsWatcher = client.watchAppointments(state: .scheduled)
            .nabla.drive(
                receiveValue: { [weak self] response in
                    self?.scheduledAppointments = response.data
                    self?.isLoadingScheduledAppointments = false
                    self?.isRefreshingScheduledAppointments = response.refreshingState.isRefreshing
                },
                receiveError: { [weak self] error in
                    self?.alert = .error(
                        title: L10n.appointmentsScreenLoadListErrorTitle,
                        error: error,
                        fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
                    )
                    self?.isLoadingScheduledAppointments = false
                    self?.isRefreshingScheduledAppointments = false
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
            case .scheduled:
                guard !isLoadingMoreScheduledAppointments else { return }
                isLoadingMoreScheduledAppointments = true
                try await scheduledAppointments.loadMore?()
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
        case .scheduled:
            isLoadingMoreScheduledAppointments = false
        case .finalized:
            isLoadingMoreFinalizedAppointments = false
        }
    }
}

extension AppointmentListViewModelImpl: AppointmentCellViewModelDelegate {
    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapJoinVideoCall room: Location.RemoteLocation.VideoCallRoom) {
        videoCallRoom = room
    }

    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapJoinExternalCallURL url: URL) {
        externalCallURL = url
    }

    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapSecondaryActionsButtonFor appointment: Appointment) {
        delegate?.appointmentListDidSelectAppointment(appointment)
    }
}
