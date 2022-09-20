import Combine
import Foundation
import NablaCore

protocol AppointmentListViewModelDelegate: AnyObject {
    func appointmentListViewModel(_ viewModel: AppointmentListViewModel, didJoinVideoCall room: Appointment.VideoCallRoom)
    func appointmentListViewModelDidSelectNewAppointment(_ viewModel: AppointmentListViewModel)
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

enum AppointmentsViewModal {
    case alert(AlertViewModel)
    case sheet(SheetViewModel<Int>)
}

// sourcery: AutoMockable
protocol AppointmentListViewModel: ViewModel, AppointmentCellViewModelDelegate {
    var selectedSelector: AppointmentsSelector { get set }
    var appointments: [Appointment] { get }
    var isLoading: Bool { get }
    var modal: AppointmentsViewModal? { get set }
    
    func userDidReachEndOfList()
    func userDidTapCreateAppointmentButton()
}

final class AppointmentListViewModelImpl: AppointmentListViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: AppointmentListViewModelDelegate?
    
    @Published var selectedSelector: AppointmentsSelector = .upcoming
    @Published var modal: AppointmentsViewModal?
    
    var isLoading: Bool {
        switch selectedSelector {
        case .upcoming: return isLoadingUpcomingAppointments
        case .finalized: return isLoadingFinalizedAppointments
        }
    }
    
    var appointments: [Appointment] {
        switch selectedSelector {
        case .upcoming: return upcomingAppointments.data
        case .finalized: return finalizedAppointments.data
        }
    }
    
    func userDidReachEndOfList() {
        Task(priority: .userInitiated) { [weak self] in
            await self?.loadMoreAppointments()
        }
    }
    
    func userDidTapCreateAppointmentButton() {
        delegate?.appointmentListViewModelDidSelectNewAppointment(self)
    }
    
    func userDidTapCancelAppointment(_ appointment: Appointment) {
        displayCancelAppointmentConfirmation(appointment)
    }
    
    func userDidConfirmCancelAppointment(_ appointment: Appointment) {
        Task { [weak self] in
            try await self?.cancelAppointment(appointment)
        }
    }
    
    // MARK: Init
    
    init(
        client: NablaSchedulingClient
    ) {
        self.client = client
        watchUpcomingAppointments()
        watchFinalizedAppointments()
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let preAppointmentPeriod = TimeInterval(15 * 60)
    }
    
    private let client: NablaSchedulingClient
    
    @Published private var upcomingAppointments: PaginatedList<Appointment> = .init(data: [], hasMore: false, loadMore: nil)
    @Published private var finalizedAppointments: PaginatedList<Appointment> = .init(data: [], hasMore: false, loadMore: nil)
    @Published private var isLoadingUpcomingAppointments = false
    @Published private var isLoadingFinalizedAppointments = false
    
    private var isLoadingMoreUpcomingAppointments = false
    private var isLoadingMoreFinalizedAppointments = false
    
    private var upcomingAppointmentsWatcher: AnyCancellable?
    private var finalizedAppointmentsWatcher: AnyCancellable?
    
    private func watchUpcomingAppointments() {
        isLoadingUpcomingAppointments = true
        
        upcomingAppointmentsWatcher = client.watchAppointments(state: .upcoming)
            .nabla.drive(
                receiveValue: { [weak self] data in
                    self?.upcomingAppointments = data
                    self?.isLoadingUpcomingAppointments = false
                },
                receiveError: { [weak self] error in
                    self?.modal = .alert(.error(
                        title: L10n.appointmentsScreenLoadListErrorTitle,
                        error: error,
                        fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
                    ))
                    self?.isLoadingUpcomingAppointments = false
                }
            )
    }
    
    private func watchFinalizedAppointments() {
        isLoadingFinalizedAppointments = true
        
        finalizedAppointmentsWatcher = client.watchAppointments(state: .finalized)
            .nabla.drive(
                receiveValue: { [weak self] data in
                    self?.finalizedAppointments = data
                    self?.isLoadingFinalizedAppointments = false
                },
                receiveError: { [weak self] error in
                    self?.modal = .alert(.error(
                        title: L10n.appointmentsScreenLoadListErrorTitle,
                        error: error,
                        fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
                    ))
                    self?.isLoadingFinalizedAppointments = false
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
            modal = .alert(.error(
                title: L10n.appointmentsScreenLoadListErrorTitle,
                error: error,
                fallbackMessage: L10n.appointmentsScreenLoadListErrorMessage
            ))
        }
        switch selectedSelector {
        case .upcoming:
            isLoadingMoreUpcomingAppointments = false
        case .finalized:
            isLoadingMoreFinalizedAppointments = false
        }
    }
    
    private func cancelAppointment(_ appointment: Appointment) async throws {
        do {
            try await client.cancelAppointment(withId: appointment.id)
        } catch {
            modal = .alert(.error(
                title: L10n.appointmentsScreenCancelAppointmentErrorTitle,
                error: ServerError(underlyingError: nil, message: nil),
                fallbackMessage: L10n.appointmentsScreenCancelAppointmentErrorMessage
            ))
        }
    }
    
    private func displayAppointmentSecondaryActions(_ appointment: Appointment) {
        guard let index = appointments.firstIndex(where: { $0.id == appointment.id }) else { return }
        modal = .sheet(.init(
            source: index,
            actions: [
                .destructive(title: L10n.appointmentsScreenSecondaryActionsSheetCancelAppointmentButton) { [weak self] in
                    self?.userDidTapCancelAppointment(appointment)
                },
            ],
            cancel: L10n.appointmentsScreenSecondaryActionsSheetCloseButton
        ))
    }
    
    private func displayCancelAppointmentConfirmation(_ appointment: Appointment) {
        modal = .alert(.init(
            title: L10n.appointmentsScreenCancelAppointmentModalTitle,
            message: L10n.appointmentsScreenCancelAppointmentModalMessage,
            actions: [
                .destructive(title: L10n.appointmentsScreenCancelAppointmentModalConfirmButton) { [weak self] in
                    self?.userDidConfirmCancelAppointment(appointment)
                },
                .cancel(title: L10n.appointmentsScreenCancelAppointmentModalCloseButton),
            ]
        ))
    }
    
    private static func format(_ error: Error, fallback: String) -> String {
        if let serverError = error as? ServerError {
            return serverError.message ?? fallback
        }
        if let networkError = error as? NetworkError {
            return networkError.message ?? fallback
        }
        return fallback
    }
}

extension AppointmentListViewModelImpl: AppointmentCellViewModelDelegate {
    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapJoinVideoCall room: Appointment.VideoCallRoom) {
        delegate?.appointmentListViewModel(self, didJoinVideoCall: room)
    }
    
    func appointmentCellViewModel(_: AppointmentCellViewModel, didTapSecondaryActionsButtonFor appointment: Appointment) {
        displayAppointmentSecondaryActions(appointment)
    }
}
