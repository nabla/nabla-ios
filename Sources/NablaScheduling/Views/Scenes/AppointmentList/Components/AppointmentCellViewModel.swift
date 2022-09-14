import Foundation
import NablaCore

protocol AppointmentCellViewModelDelegate: AnyObject {
    func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapJoinVideoCall room: Appointment.VideoCallRoom)
    func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapSecondaryActionsButtonFor appointment: Appointment)
}

// sourcery: AutoMockable
protocol AppointmentCellViewModel: ViewModel {
    var avatar: AvatarViewModel { get }
    var title: String { get }
    var subtitle: String { get }
    var enabled: Bool { get }
    var primaryActionTitle: String? { get }
    var showSecondaryActionsButton: Bool { get }
    
    func userDidTapPrimaryActionButton()
    func userDidTapSecondaryActionsButton()
}

final class AppointmentCellViewModelImpl: AppointmentCellViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: AppointmentCellViewModelDelegate?
    
    @Published var subtitle: String = ""
    
    var avatar: AvatarViewModel {
        AvatarViewModel(
            url: appointment.provider.avatarUrl?.absoluteString,
            text: appointment.provider.formatName(style: .abbreviated)
        )
    }
    
    var title: String {
        appointment.provider.formatName(style: .long)
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
    
    var showSecondaryActionsButton: Bool {
        appointment.start.nabla.isFuture && !isPreAppointmentPeriod
    }
    
    func userDidTapPrimaryActionButton() {
        guard let videoCallRoom = appointment.videoCallRoom else { return }
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
    
    private var currentVideoCallWatcher: Cancellable?
    
    @Published private var currentVideoCallToken: String?
    @Published private var joinableVideoCallRoom: Appointment.VideoCallRoom?
    
    private var isPreAppointmentPeriod: Bool {
        appointment.start.nabla.isFuture && appointment.start.nabla.timeIntervalSinceNow < 10 * 60
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
        joinableVideoCallRoom = isPreAppointmentPeriod || appointment.start.nabla.isPast ? appointment.videoCallRoom : nil
    }
    
    private func format(_ date: Date) -> String {
        if isPreAppointmentPeriod {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .numeric
            formatter.unitsStyle = .full
            formatter.formattingContext = .standalone
            return formatter.localizedString(for: date, relativeTo: .nabla.now())
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = true
            return formatter.string(from: date)
        }
    }
    
    private func observeCurrentVideoCall() {
        currentVideoCallWatcher = videoCallClient?.watchCurrentVideoCall { [weak self] token in
            self?.currentVideoCallToken = token
        }
    }
}
