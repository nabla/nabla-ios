import Combine
import Foundation
import NablaCore

public protocol AppointmentDetailsDelegate: AnyObject {
    @MainActor func appointmentDetailsDidCancelAppointment(_ appointment: Appointment)
}

enum AppointmentDetailsModal {
    case alert(AlertViewModel)
    case detailSheet(SheetViewModel<Void>)
}

struct AppointmentsDetailsViewItem {
    let provider: Provider
    let locationType: LocationType
    let location: String?
    let locationDetails: String?
    let date: Date
    let price: String?
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
    
    @MainActor func userDidTapAppointmentLocation()
    @MainActor func userDidTapCancelButton()
}

@MainActor
final class AppointmentDetailsViewModelImpl: ObservableObject, AppointmentDetailsViewModel {
    // MARK: - Internal
    
    weak var delegate: AppointmentDetailsDelegate?
    
    @Published var modal: AppointmentDetailsModal?
    @Published var state: AppointmentsDetailsViewState = .loading
    
    func userDidTapAppointmentLocation() {
        guard let address = appointment?.location.asPhysical?.address else { return }
        
        let actions = universalLinkGenerator.makeUniversalLinks(forAddress: address)
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
            locationType: appointment.location.type ?? .remote,
            location: location(for: appointment),
            locationDetails: locationDetails(for: appointment),
            date: appointment.start,
            price: price(for: appointment),
            showCancelButton: appointment.start.nabla.isFuture && !isAppointmentAboutToStart(appointment)
        )
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
                .default(title: L10n.appointmentDetailsScreenCancelAppointmentModalCloseButton, handler: {}),
            ]
        ))
    }
    
    private func userDidConfirmCancelAppointment() {
        Task {
            await cancelAppointment()
        }
    }
    
    private func location(for appointment: Appointment) -> String? {
        switch appointment.location {
        case .unknown, .remote: return nil
        case let .physical(location): return addressFormatter.format(location.address)
        }
    }
    
    private func locationDetails(for appointment: Appointment) -> String? {
        switch appointment.location {
        case .unknown, .remote: return nil
        case let .physical(location): return location.address.extraDetails
        }
    }
    
    private func price(for appointment: Appointment) -> String? {
        switch appointment.state {
        case .finalized, .scheduled:
            guard let price = appointment.price else { return nil }
            return format(price: price)
        case let .pending(paymentRequirement):
            guard let price = paymentRequirement?.price ?? appointment.price else { return nil }
            return format(price: price)
        }
    }
    
    private func format(price: Price) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = price.currencyCode
        return formatter.string(for: price.amount)
    }
}
