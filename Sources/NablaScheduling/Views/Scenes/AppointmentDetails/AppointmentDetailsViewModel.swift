import Combine
import Foundation
import NablaCore

public protocol AppointmentDetailsDelegate: AnyObject {
    func appointmentDetailsDidCancelAppointment(_ appointment: Appointment)
}

enum AppointmentDetailsModal {
    case alert(AlertViewModel)
    case detailSheet(SheetViewModel<Void>)
}

struct AppointmentsDetailsViewItem {
    let provider: Provider
    let caption: String
    let captionIcon: AppointmentDetailsView.CaptionIcon
    let details1: String?
    let details2: String?
    let showCancelButton: Bool
}

enum AppointmentsDetailsViewState {
    case loading
    case ready(AppointmentsDetailsViewItem)
}

// sourcery: AutoMockable
protocol AppointmentDetailsViewModel: ViewModel {
    @MainActor var modal: AppointmentDetailsModal? { get set }
    @MainActor var state: AppointmentsDetailsViewState { get }
    
    @MainActor func userDidTapAppointmentDetails()
    @MainActor func userDidTapCancelButton()
}

@MainActor
final class AppointmentDetailsViewModelImpl: ObservableObject, AppointmentDetailsViewModel {
    // MARK: - Internal
    
    weak var delegate: AppointmentDetailsDelegate?
    
    @Published var modal: AppointmentDetailsModal?
    @Published var state: AppointmentsDetailsViewState = .loading
    
    func userDidTapAppointmentDetails() {
        guard let address = appointment?.location.asPhysical?.address else { return }
        
        let actions = universalLinkGenerator.makeUniversalLinks(forAdress: address)
            .compactMap { universalLink -> SheetViewModel<Void>.Action? in
                .default(
                    title: universalLink.displayName,
                    handler: universalLink.open
                )
            }
        
        if actions.isEmpty { return }
        modal = .detailSheet(.init(actions: actions))
    }
    
    func userDidTapCancelButton() {
        displayCancelAppointmentConfirmation()
    }
    
    // MARK: Init
    
    nonisolated init(
        appointmentId: UUID,
        delegate: AppointmentDetailsDelegate,
        client: NablaSchedulingClient,
        addressFormatter: AddressFormatter,
        universalLinkGenerator: UniversalLinkGenerator
    ) {
        self.appointmentId = appointmentId
        self.delegate = delegate
        self.client = client
        self.addressFormatter = addressFormatter
        self.universalLinkGenerator = universalLinkGenerator
        
        Task {
            await watchAppointment()
        }
    }
    
    nonisolated init(
        appointment: Appointment,
        delegate: AppointmentDetailsDelegate,
        client: NablaSchedulingClient,
        addressFormatter: AddressFormatter,
        universalLinkGenerator: UniversalLinkGenerator
    ) {
        appointmentId = appointment.id
        self.appointment = appointment
        self.delegate = delegate
        self.client = client
        self.addressFormatter = addressFormatter
        self.universalLinkGenerator = universalLinkGenerator
        
        Task {
            await display(appointment: appointment)
            await watchAppointment()
        }
    }
    
    // MARK: - Private
    
    private let appointmentId: UUID
    private let client: NablaSchedulingClient
    private let addressFormatter: AddressFormatter
    private let universalLinkGenerator: UniversalLinkGenerator
    
    private var appointmentWatcher: AnyCancellable?
    private var appointment: Appointment?
    
    private func isAppointmentAboutToStart(_ appointment: Appointment) -> Bool {
        appointment.start.nabla.isFuture && appointment.start.nabla.timeIntervalSinceNow < 10 * 60
    }
    
    private func makeViewItem(for appointment: Appointment) -> AppointmentsDetailsViewItem {
        .init(
            provider: appointment.provider,
            caption: caption(for: appointment),
            captionIcon: captionIcon(for: appointment),
            details1: details1(for: appointment),
            details2: details2(for: appointment),
            showCancelButton: appointment.start.nabla.isFuture && !isAppointmentAboutToStart(appointment)
        )
    }
    
    private func caption(for appointment: Appointment) -> String {
        if appointment.start.nabla.isToday {
            return L10n.confirmationScreenCaptionFormatToday(formatTime(date: appointment.start))
        } else {
            return L10n.confirmationScreenCaptionFormat(formatTimeAndDate(date: appointment.start))
        }
    }
    
    private func captionIcon(for appointment: Appointment) -> AppointmentDetailsView.CaptionIcon {
        switch appointment.location {
        case .remote: return .video
        case .physical: return .house
        case .unknown: return .video
        }
    }
    
    private func details1(for appointment: Appointment) -> String? {
        switch appointment.location {
        case .remote, .unknown: return nil
        case let .physical(physicalLocation): return addressFormatter.format(physicalLocation.address)
        }
    }
    
    private func details2(for appointment: Appointment) -> String? {
        switch appointment.location {
        case .remote, .unknown: return nil
        case let .physical(physicalLocation): return physicalLocation.address.extraDetails
        }
    }
    
    private func watchAppointment() {
        if appointment == nil {
            state = .loading
        }
        appointmentWatcher = client.watchAppointment(id: appointmentId)
            .nabla.drive(
                receiveValue: { [weak self] appointment in
                    self?.display(appointment: appointment)
                },
                receiveError: { [weak self] error in
                    self?.modal = .alert(.error(
                        title: L10n.appointmentDetailsScreenWatchAppointmentErrorTitle,
                        error: error,
                        fallbackMessage: L10n.appointmentDetailsScreenWatchAppointmentErrorMessage
                    ))
                }
            )
    }
    
    private func display(appointment: Appointment) {
        self.appointment = appointment
        let viewItem = makeViewItem(for: appointment)
        state = .ready(viewItem)
    }
    
    private func cancelAppointment() async {
        guard let appointment = appointment else { return }
        do {
            try await client.cancelAppointment(withId: appointment.id)
            delegate?.appointmentDetailsDidCancelAppointment(appointment)
        } catch {
            modal = .alert(.error(
                title: L10n.appointmentDetailsScreenCancelAppointmentErrorTitle,
                error: error,
                fallbackMessage: L10n.appointmentDetailsScreenCancelAppointmentErrorMessage
            ))
        }
    }
    
    private func displayCancelAppointmentConfirmation() {
        modal = .alert(.init(
            title: L10n.appointmentDetailsScreenCancelAppointmentModalTitle,
            message: L10n.appointmentDetailsScreenCancelAppointmentModalMessage,
            actions: [
                .destructive(title: L10n.appointmentDetailsScreenCancelAppointmentModalConfirmButton) { [weak self] in
                    self?.userDidConfirmCancelAppointment()
                },
                .cancel(title: L10n.appointmentDetailsScreenCancelAppointmentModalCloseButton),
            ]
        ))
    }
    
    private func userDidConfirmCancelAppointment() {
        Task {
            await cancelAppointment()
        }
    }
    
    private func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formatTimeAndDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
