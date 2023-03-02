import Combine
import Foundation
import NablaCore

protocol AppointmentConfirmationViewModelDelegate: AnyObject {
    func appointmentConfirmationViewModel(_ viewModel: AppointmentConfirmationViewModel, confirm: Appointment) async throws
    func appointmentConfirmationViewModel(_ viewModel: AppointmentConfirmationViewModel, didConfirm: Appointment)
}

enum AppointmentConfirmationModal {
    case alert(AlertViewModel)
    case detailSheet(SheetViewModel<Void>)
}

// sourcery: AutoMockable
protocol AppointmentConfirmationViewModel: ViewModel {
    @MainActor var provider: Provider? { get }
    @MainActor var locationType: LocationType { get }
    @MainActor var location: String? { get }
    @MainActor var locationDetails: String? { get }
    @MainActor var date: Date { get }
    @MainActor var price: String? { get }
    @MainActor var agreesWithFirstConsent: Bool { get set }
    @MainActor var agreesWithSecondConsent: Bool { get set }
    @MainActor var canConfirm: Bool { get }
    @MainActor var confirmActionTitle: String { get }
    @MainActor var isConfirming: Bool { get }
    @MainActor var isLoadingConsents: Bool { get }
    @MainActor var consents: ConsentsViewModel? { get }
    @MainActor var consentsLoadingError: ConsentsErrorViewModel? { get }
    @MainActor var modal: AppointmentConfirmationModal? { get set }
    
    @MainActor func userDidTapAppointmentLocation()
    @MainActor func userDidTapConfirmButton()
}

@MainActor
final class AppointmentConfirmationViewModelImpl: AppointmentConfirmationViewModel, ObservableObject {
    // MARK: - Internal

    weak var delegate: AppointmentConfirmationViewModelDelegate?

    @Published var agreesWithFirstConsent = false
    @Published var agreesWithSecondConsent = false
    @Published private(set) var isConfirming = false
    @Published private(set) var isLoadingConsents = false
    @Published private(set) var consentsLoadingError: ConsentsErrorViewModel?
    @Published private(set) var consents: ConsentsViewModel?
    @Published private(set) var provider: Provider?
    @Published var modal: AppointmentConfirmationModal?
    
    var locationType: LocationType {
        appointment.location.type ?? .remote
    }
    
    var location: String? {
        switch appointment.location {
        case .remote, .unknown: return nil
        case let .physical(physicalLocation):
            return addressFormatter.format(physicalLocation.address)
        }
    }
    
    var locationDetails: String? {
        switch appointment.location {
        case .remote, .unknown: return nil
        case let .physical(physicalLocation):
            return physicalLocation.address.extraDetails
        }
    }
    
    var date: Date {
        appointment.start
    }
    
    var price: String? {
        price(for: appointment)
    }

    var canConfirm: Bool {
        agreesWithFirstConsent && agreesWithSecondConsent
    }
    
    var confirmActionTitle: String {
        if case let .pending(paymentRequirement) = appointment.state, paymentRequirement != nil {
            return L10n.confirmationScreenActionButtonLabelPaidAppointment
        } else {
            return L10n.confirmationScreenActionButtonLabelFreeAppointment
        }
    }
    
    func userDidTapAppointmentLocation() {
        guard let physicalLocation = appointment.location.asPhysical else { return }
        
        let actions = universalLinkGenerator.makeUniversalLinks(forAddress: physicalLocation.address)
            .compactMap { universalLink -> SheetViewModel<Void>.Action? in
                .default(
                    title: universalLink.displayName,
                    handler: universalLink.open
                )
            }
        
        if actions.isEmpty { return }
        modal = .detailSheet(.init(actions: actions))
    }

    func userDidTapConfirmButton() {
        Task {
            await confirmAppointment()
        }
    }
    
    func userDidTapErrorViewRetryButton() {
        watchConsents()
    }

    // MARK: Init

    nonisolated init(
        appointment: Appointment,
        client: NablaSchedulingClient,
        addressFormatter: AddressFormatter,
        universalLinkGenerator: UniversalLinkGenerator,
        logger: Logger,
        delegate: AppointmentConfirmationViewModelDelegate
    ) {
        self.appointment = appointment
        self.client = client
        self.addressFormatter = addressFormatter
        self.universalLinkGenerator = universalLinkGenerator
        self.logger = logger
        self.delegate = delegate
        
        Task {
            await watchProvider()
            await watchConsents()
        }
    }

    // MARK: - Private

    private let appointment: Appointment
    private let client: NablaSchedulingClient
    private let addressFormatter: AddressFormatter
    private let universalLinkGenerator: UniversalLinkGenerator
    private let logger: Logger
    
    private var providerWatcher: AnyCancellable?
    private var consentsWatcher: AnyCancellable?

    private func confirmAppointment() async {
        guard canConfirm, !isConfirming else {
            return
        }
        isConfirming = true
        do {
            try await schedulePendingAppointment(appointment: appointment)
        } catch {
            logger.warning(message: "Failed to schedule appointment", error: error, extra: ["appointment_id": appointment.id])
            modal = .alert(.error(
                title: L10n.confirmationScreenErrorTitle,
                error: error,
                fallbackMessage: L10n.confirmationScreenErrorMessage
            ))
        }
        isConfirming = false
    }
    
    private func schedulePendingAppointment(appointment: Appointment) async throws {
        try await delegate?.appointmentConfirmationViewModel(self, confirm: appointment)
        let confirmedAppointment = try await client.schedulePendingAppointment(withId: appointment.id)
        delegate?.appointmentConfirmationViewModel(self, didConfirm: confirmedAppointment)
    }

    private func watchProvider() {
        guard provider == nil else {
            return
        }
        providerWatcher = client.watchProvider(id: appointment.provider.id)
            .nabla.drive(
                receiveValue: { [weak self] provider in
                    self?.provider = provider
                },
                receiveError: { [weak self] error in
                    self?.modal = .alert(.error(
                        title: L10n.confirmationScreenErrorTitle,
                        error: error,
                        fallbackMessage: ""
                    ))
                }
            )
    }
    
    private func watchConsents() {
        guard consents == nil else {
            return
        }

        guard !isLoadingConsents else {
            return
        }
        
        guard let locationType = appointment.location.type else {
            // TODO: Logger
            return
        }

        isLoadingConsents = true
        consentsWatcher = client.watchConsents(location: locationType)
            .nabla.drive(
                receiveValue: { [weak self] consents in
                    guard let self = self else { return }
                    self.agreesWithFirstConsent = consents.firstConsentHtml == nil
                    self.agreesWithSecondConsent = consents.secondConsentHtml == nil

                    let firstConsentHtml = self.formatConsentHtmlText(consents.firstConsentHtml)
                    let secondConsentHtml = self.formatConsentHtmlText(consents.secondConsentHtml)
                    self.consents = ConsentsViewModel(
                        firstConsentHtml: firstConsentHtml,
                        firstConsentContainsLink: self.consentContainsLink(firstConsentHtml),
                        secondConsentHtml: secondConsentHtml,
                        secondConsentContainsLink: self.consentContainsLink(secondConsentHtml)
                    )
                    self.isLoadingConsents = false
                },
                receiveError: { [weak self] error in
                    guard let self = self else { return }

                    let errorMessage: String

                    if let serverError = error as? ServerError, let message = serverError.message {
                        errorMessage = message
                    } else if let networkError = error as? NetworkError, let message = networkError.message {
                        errorMessage = message
                    } else {
                        errorMessage = L10n.confirmationScreenErrorTitle
                    }

                    self.consentsLoadingError = ConsentsErrorViewModel(
                        message: errorMessage,
                        handler: { [weak self] in
                            self?.watchConsents()
                        }
                    )
                    self.isLoadingConsents = false
                }
            )
    }
    
    private func formatConsentHtmlText(_ maybeHtmlString: String?) -> NSAttributedString? {
        if let htmlString = maybeHtmlString {
            return try? NSMutableAttributedString(
                data: Data(htmlString.utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            ).trimWhiteSpacesAndNewLines()
        } else {
            return nil
        }
    }
    
    private func consentContainsLink(_ maybeConsentAttributedString: NSAttributedString?) -> Bool {
        guard let consentAttributedString = maybeConsentAttributedString else {
            return false
        }
        
        var containsLink = false
        consentAttributedString.enumerateAttribute(.link, in: NSMakeRange(0, consentAttributedString.length)) { link, _, _ in
            containsLink = containsLink || link != nil
        }
        
        return containsLink
    }
    
    private func price(for appointment: Appointment) -> String? {
        switch appointment.state {
        case .finalized, .upcoming:
            guard let price = appointment.price else { return nil }
            return format(price: price)
        case let .pending(paymentRequirement):
            // Prioritize payment requirement over price
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

private extension NSAttributedString {
    // https://stackoverflow.com/a/54900313/2508174
    func trimWhiteSpacesAndNewLines() -> NSAttributedString {
        let invertedSet = CharacterSet.whitespacesAndNewlines.inverted
        let startRange = string.utf16.description.rangeOfCharacter(from: invertedSet)
        let endRange = string.utf16.description.rangeOfCharacter(from: invertedSet, options: .backwards)
        guard let startLocation = startRange?.upperBound, let endLocation = endRange?.lowerBound else {
            return NSAttributedString(string: string)
        }

        let location = string.utf16.distance(from: string.startIndex, to: startLocation) - 1
        let length = string.utf16.distance(from: startLocation, to: endLocation) + 2
        let range = NSRange(location: location, length: length)
        return attributedSubstring(from: range)
    }
}
