import Combine
import Foundation
import NablaCore

protocol AppointmentCellViewModelDelegate: AnyObject {
    func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapJoinVideoCall room: Location.RemoteLocation.VideoCallRoom)
    func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapSecondaryActionsButtonFor appointment: Appointment)
}

// sourcery: AutoMockable
protocol AppointmentCellViewModel: ViewModel {
    @MainActor var avatar: AvatarViewModel { get }
    @MainActor var title: String { get }
    @MainActor var subtitle: String { get }
    @MainActor var enabled: Bool { get }
    @MainActor var primaryActionTitle: String? { get }
    @MainActor var showDisclosureIndicator: Bool { get }
    
    @MainActor func userDidTapPrimaryActionButton()
    @MainActor func userDidTapSecondaryActionsButton()
}

@MainActor
final class AppointmentCellViewModelImpl: AppointmentCellViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: AppointmentCellViewModelDelegate?
    
    @Published var subtitle: String = ""
    
    var avatar: AvatarViewModel {
        AvatarViewModel(
            url: appointment.provider.avatarUrl?.absoluteString,
            text: ProviderNameComponentsFormatter(style: .initials).string(from: .init(appointment.provider))
        )
    }
    
    var title: String {
        ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(appointment.provider))
    }
    
    var enabled: Bool {
        appointment.state == .upcoming
    }
    
    var primaryActionTitle: String? {
        guard let room = joinableVideoCallRoom else { return nil }
        if currentVideoCallToken == room.token {
            return L10n.appointmentsScreenCellJoinInprogressButtonLabel
        } else {
            return L10n.appointmentsScreenCellJoinButtonLabel
        }
    }
    
    var showDisclosureIndicator: Bool {
        appointment.state == .upcoming
    }
    
    func userDidTapPrimaryActionButton() {
        guard
            let remoteLocation = appointment.location.asRemote,
            let videoCallRoom = remoteLocation.videoCallRoom
        else { return }
        delegate?.appointmentCellViewModel(self, didTapJoinVideoCall: videoCallRoom)
    }
    
    func userDidTapSecondaryActionsButton() {
        delegate?.appointmentCellViewModel(self, didTapSecondaryActionsButtonFor: appointment)
    }
    
    init(
        appointment: Appointment,
        videoCallClient: VideoCallClient?,
        delegate: AppointmentCellViewModelDelegate
    ) {
        self.appointment = appointment
        self.videoCallClient = videoCallClient
        self.delegate = delegate
        
        observeTime()
        observeCurrentVideoCall()
    }
    
    // MARK: - Private
    
    private let appointment: Appointment
    private let videoCallClient: VideoCallClient?
    
    private var currentVideoCallWatcher: AnyCancellable?
    
    @Published private var currentVideoCallToken: String?
    @Published private var joinableVideoCallRoom: Location.RemoteLocation.VideoCallRoom?
    
    private var isAppointmentAboutToStart: Bool {
        appointment.start.nabla.isFuture && appointment.start.nabla.timeIntervalSinceNow < 10 * 60
    }
    
    private var hasAppointmentStartedRecently: Bool {
        appointment.start.nabla.isPast && abs(appointment.start.nabla.timeIntervalSinceNow) < 10 * 60
    }
    
    private func observeTime() {
        updateTimeConstraintedProperties()
        
        // Only self-refresh date display for dates in the [-1h; +1h] range
        if abs(appointment.start.nabla.timeIntervalSinceNow) < 60 * 60 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.observeTime()
            }
        }
    }
    
    private func updateTimeConstraintedProperties() {
        subtitle = format(appointment.start)
        if
            let remoteLocation = appointment.location.asRemote,
            appointment.state != .finalized,
            isAppointmentAboutToStart || appointment.start.nabla.isPast {
            joinableVideoCallRoom = remoteLocation.videoCallRoom
        } else {
            joinableVideoCallRoom = nil
        }
    }
    
    private func format(_ date: Date) -> String {
        if isAppointmentAboutToStart || hasAppointmentStartedRecently {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .numeric
            formatter.unitsStyle = .full
            formatter.formattingContext = .standalone
            return formatter.localizedString(for: date, relativeTo: .nabla.now())
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
    }
    
    private func observeCurrentVideoCall() {
        guard let client = videoCallClient else { return }
        currentVideoCallWatcher = client.watchCurrentVideoCall()
            .nabla.drive { [weak self] token in
                self?.currentVideoCallToken = token
            }
    }
}
