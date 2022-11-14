import Combine
import Foundation
import NablaCore

protocol AppointmentConfirmationViewModelDelegate: AnyObject {
    func appointmentConfirmationViewModel(_ viewModel: AppointmentConfirmationViewModel, didConfirm: Appointment)
}

// sourcery: AutoMockable
protocol AppointmentConfirmationViewModel: ViewModel {
    var provider: Provider? { get }
    var appointmentDate: Date { get }
    var agreesWithFirstConsent: Bool { get set }
    var agreesWithSecondConsent: Bool { get set }
    var canConfirm: Bool { get }
    var isConfirming: Bool { get }
    var isLoadingConsents: Bool { get }
    var consents: ConsentsViewModel? { get }
    var consentsLoadingError: ConsentsErrorViewModel? { get }
    var error: AlertViewModel? { get set }

    func userDidTapConfirmButton()
}

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
    @Published var error: AlertViewModel?

    var appointmentDate: Date {
        timeSlot.start
    }

    var canConfirm: Bool {
        agreesWithFirstConsent && agreesWithSecondConsent
    }

    func userDidTapConfirmButton() {
        Task(priority: .userInitiated) { [weak self] in
            await self?.confirmAppointment()
        }
    }
    
    func userDidTapErrorViewRetryButton() {
        Task(priority: .userInitiated) { [weak self] in
            await self?.fetchConsents()
        }
    }

    private var providerWatcher: AnyCancellable?

    // MARK: Init

    init(
        category: Category,
        timeSlot: AvailabilitySlot,
        client: NablaSchedulingClient,
        delegate: AppointmentConfirmationViewModelDelegate
    ) {
        self.category = category
        self.timeSlot = timeSlot
        self.client = client
        self.delegate = delegate
        watchProvider()
        Task(priority: .userInitiated) { [weak self] in
            await self?.fetchConsents()
        }
    }

    // MARK: - Private

    private let category: Category
    private let timeSlot: AvailabilitySlot
    private let client: NablaSchedulingClient

    private func confirmAppointment() async {
        guard canConfirm, !isConfirming else {
            return
        }
        isConfirming = true
        do {
            let appointment = try await client.scheduleAppointment(
                categoryId: category.id,
                providerId: timeSlot.providerId,
                date: timeSlot.start
            )
            await MainActor.run { [delegate] in
                delegate?.appointmentConfirmationViewModel(self, didConfirm: appointment)
            }
        } catch {
            self.error = .error(
                title: L10n.confirmationScreenErrorTitle,
                error: error,
                fallbackMessage: L10n.confirmationScreenErrorMessage
            )
        }
        isConfirming = false
    }

    private func watchProvider() {
        guard provider == nil else {
            return
        }
        providerWatcher = client.watchProvider(id: timeSlot.providerId)
            .nabla.drive(
                receiveValue: { [weak self] provider in
                    self?.provider = provider
                },
                receiveError: { [weak self] error in
                    self?.error = .error(
                        title: L10n.confirmationScreenErrorTitle,
                        error: error,
                        fallbackMessage: ""
                    )
                }
            )
    }
    
    private func fetchConsents() async {
        guard !isLoadingConsents else {
            return
        }
        
        isLoadingConsents = true
        do {
            let consents = try await client.fetchConsents()
            
            agreesWithFirstConsent = consents.firstConsentHtml == nil
            agreesWithSecondConsent = consents.secondConsentHtml == nil
            
            let firstConsentHtml = formatConsentHtmlText(consents.firstConsentHtml)
            let secondConsentHtml = formatConsentHtmlText(consents.secondConsentHtml)
            self.consents = ConsentsViewModel(
                firstConsentHtml: firstConsentHtml,
                firstConsentContainsLink: consentContainsLink(firstConsentHtml),
                secondConsentHtml: secondConsentHtml,
                secondConsentContainsLink: consentContainsLink(secondConsentHtml)
            )
        } catch {
            let errorMessage: String
            
            if let serverError = error as? ServerError, let message = serverError.message {
                errorMessage = message
            } else if let networkError = error as? NetworkError, let message = networkError.message {
                errorMessage = message
            } else {
                errorMessage = L10n.confirmationScreenErrorTitle
            }
            
            consentsLoadingError = ConsentsErrorViewModel(
                message: errorMessage,
                handler: { [weak self] in
                    Task(priority: .userInitiated) { [weak self] in
                        await self?.fetchConsents()
                    }
                }
            )
        }
        isLoadingConsents = false
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
            )
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
}
