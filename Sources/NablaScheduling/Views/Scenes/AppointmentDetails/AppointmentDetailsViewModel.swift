import Foundation
import NablaCore

public protocol AppointmentDetailsDelegate: AnyObject {
    func appointmentDetailsDidCancelAppointment(_ appointment: Appointment)
}

enum AppointmentDetailsModal {
    case alert(AlertViewModel)
    case detailSheet(SheetViewModel<Void>)
}

// sourcery: AutoMockable
protocol AppointmentDetailsViewModel: ViewModel {
    var modal: AppointmentDetailsModal? { get set }
    var provider: Provider { get }
    var caption: String { get }
    var captionIcon: AppointmentDetailsView.CaptionIcon { get }
    var details1: String? { get }
    var details2: String? { get }
    var showCancelButton: Bool { get }
    
    func userDidTapAppointmentDetails()
    func userDidTapCancelButton()
}

final class AppointmentDetailsViewModelImpl: ObservableObject, AppointmentDetailsViewModel {
    // MARK: - Internal
    
    weak var delegate: AppointmentDetailsDelegate?
    
    @Published var modal: AppointmentDetailsModal?
    
    var provider: Provider {
        appointment.provider
    }
    
    var caption: String {
        if appointment.start.nabla.isToday {
            return L10n.confirmationScreenCaptionFormatToday(formatTime(date: appointment.start))
        } else {
            return L10n.confirmationScreenCaptionFormat(formatTimeAndDate(date: appointment.start))
        }
    }
    
    var captionIcon: AppointmentDetailsView.CaptionIcon {
        switch appointment.location {
        case .remote: return .video
        case .physical: return .house
        case .unknown: return .video
        }
    }
    
    var details1: String? {
        switch appointment.location {
        case .remote, .unknown: return nil
        case let .physical(physicalLocation): return addressFormatter.format(physicalLocation.address)
        }
    }
    
    var details2: String? {
        switch appointment.location {
        case .remote, .unknown: return nil
        case let .physical(physicalLocation): return physicalLocation.address.extraDetails
        }
    }
    
    var showCancelButton: Bool {
        appointment.start.nabla.isFuture && !isAppointmentAboutToStart
    }
    
    func userDidTapAppointmentDetails() {
        guard let address = appointment.location.asPhysical?.address else { return }
        
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
    
    init(
        appointment: Appointment,
        delegate: AppointmentDetailsDelegate,
        client: NablaSchedulingClient,
        addressFormatter: AddressFormatter,
        universalLinkGenerator: UniversalLinkGenerator
    ) {
        self.appointment = appointment
        self.delegate = delegate
        self.client = client
        self.addressFormatter = addressFormatter
        self.universalLinkGenerator = universalLinkGenerator
    }
    
    // MARK: - Private
    
    private let appointment: Appointment
    private let client: NablaSchedulingClient
    private let addressFormatter: AddressFormatter
    private let universalLinkGenerator: UniversalLinkGenerator
    
    private var isAppointmentAboutToStart: Bool {
        appointment.start.nabla.isFuture && appointment.start.nabla.timeIntervalSinceNow < 10 * 60
    }
    
    private func cancelAppointment() async {
        do {
            try await client.cancelAppointment(withId: appointment.id)
            await MainActor.run { [delegate] in
                delegate?.appointmentDetailsDidCancelAppointment(appointment)
            }
        } catch {
            modal = .alert(.error(
                title: L10n.appointmentDetailsScreenCancelAppointmentErrorTitle,
                error: ServerError(underlyingError: nil, message: nil),
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
