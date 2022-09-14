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
    var agreesWithConsultationDisclaimer: Bool { get set }
    var agreesWithPersonalDataDisclaimer: Bool { get set }
    var canConfirm: Bool { get }
    var isConfirming: Bool { get }
    var error: AlertViewModel? { get set }

    func userDidTapConfirmButton()
}

final class AppointmentConfirmationViewModelImpl: AppointmentConfirmationViewModel, ObservableObject {
    // MARK: - Internal

    weak var delegate: AppointmentConfirmationViewModelDelegate?

    @Published var agreesWithConsultationDisclaimer = false
    @Published var agreesWithPersonalDataDisclaimer = false
    @Published private(set) var isConfirming = false
    @Published private(set) var provider: Provider?
    @Published var error: AlertViewModel?

    var appointmentDate: Date {
        timeSlot.start
    }

    var canConfirm: Bool {
        agreesWithConsultationDisclaimer && agreesWithPersonalDataDisclaimer
    }

    func userDidTapConfirmButton() {
        Task(priority: .userInitiated) { [weak self] in
            await self?.confirmAppointment()
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

    func watchProvider() {
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
}
