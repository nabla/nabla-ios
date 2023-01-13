import Foundation
#if canImport(LiveKitClient)
    import LiveKitClient
#else
    import LiveKit
#endif
import protocol NablaCore.ErrorReporter

final class VideoCallRoomErrorReporterHelper {
    init(errorReporter: ErrorReporter) {
        self.errorReporter = errorReporter
    }

    // MARK: - Private

    private let errorReporter: ErrorReporter

    private func logState(_ stateDesc: String, roomId: String?) {
        errorReporter.log(
            message: "RoomState=\(stateDesc)",
            extra: ["roomId": roomId ?? "null"],
            domain: "video-call"
        )
    }

    private func logEvent(_ eventDesc: String, roomId: String?) {
        errorReporter.log(
            message: "RoomEvent=\(eventDesc)",
            extra: ["roomId": roomId ?? "null"],
            domain: "video-call"
        )
    }
}

extension VideoCallRoomErrorReporterHelper: RoomDelegate {
    func room(_ room: Room, didConnect isReconnect: Bool) {
        if isReconnect {
            logEvent("Reconnected", roomId: room.name)
        } else {
            logEvent("Connected", roomId: room.name)
        }
    }

    func room(_ room: Room, didFailToConnect error: Error) {
        logEvent("FailedToConnect", roomId: room.name)
        errorReporter.reportError(message: "FailedToConnect", error: error)
    }

    func room(_ room: Room, didDisconnect error: Error?) {
        logEvent("Disconnected", roomId: room.name)
        errorReporter.reportError(message: "Call ended unexpectedly", error: error)
    }

    func room(_ room: Room, didUpdate connectionState: ConnectionState, oldValue _: ConnectionState) {
        logState(connectionState.asLog(), roomId: room.name)
        if case let .disconnected(reason: reason) = connectionState {
            switch reason {
            case .user:
                errorReporter.reportEvent(message: "Call ended from user")
            case let .networkError(error):
                errorReporter.reportError(message: "Disconnected with network error", error: error)
            case .none:
                errorReporter.reportEvent(message: "Call ended without error")
            }
        }
    }

    func room(_ room: Room, participantDidJoin participant: RemoteParticipant) {
        logEvent("ParticipantConnected(Participant=\(participant.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, participantDidLeave participant: RemoteParticipant) {
        logEvent("ParticipantDisconnected(Participant=\(participant.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, didUpdate _: [Participant]) {
        logEvent("ActiveSpeakersChanged", roomId: room.name)
    }

    func room(_ room: Room, didUpdate _: String?) {
        logEvent("RoomMetadataChanged", roomId: room.name)
    }

    func room(_ room: Room, participant _: Participant, didUpdate _: String?) {
        logEvent("ParticipantMetadataChanged", roomId: room.name)
    }

    func room(_ room: Room, participant: Participant, didUpdate connectionQuality: ConnectionQuality) {
        logEvent("ConnectionQualityChanged(Participant=\(participant.asLog()), Quality=\(connectionQuality.name))", roomId: room.name)
    }

    func room(_ room: Room, participant: Participant, didUpdate publication: TrackPublication, muted: Bool) {
        if muted {
            logEvent("TrackMuted(Participant=\(participant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
        } else {
            logEvent("TrackUnmuted(Participant=\(participant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
        }
    }

    func room(_ room: Room, participant _: Participant, didUpdate _: ParticipantPermissions) {
        logEvent("ParticipantPermissionsChanged", roomId: room.name)
    }

    func room(_ room: Room, participant _: RemoteParticipant, didUpdate publication: RemoteTrackPublication, streamState: StreamState) {
        logEvent("TrackStreamStateChanged(Publication=\(publication.asLog()), StreamState=\(streamState.name))", roomId: room.name)
    }

    func room(_ room: Room, participant: RemoteParticipant, didPublish publication: RemoteTrackPublication) {
        logEvent("TrackPublished(Participant=\(participant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, participant: RemoteParticipant, didUnpublish publication: RemoteTrackPublication) {
        logEvent("TrackUnpublished(Participant=\(participant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, participant: RemoteParticipant, didSubscribe publication: RemoteTrackPublication, track _: Track) {
        logEvent("TrackSubscribed(Participant=\(participant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, participant: RemoteParticipant, didFailToSubscribe _: String, error: Error) {
        logEvent("TrackSubscriptionFailed(Participant=\(participant.asLog()), error=\(error))", roomId: room.name)
    }

    func room(_ room: Room, participant: RemoteParticipant, didUnsubscribe _: RemoteTrackPublication, track _: Track) {
        logEvent("TrackUnsubscribed(Participant=\(participant.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, participant _: RemoteParticipant?, didReceive _: Data) {
        logEvent("DataReceived", roomId: room.name)
    }

    func room(_ room: Room, localParticipant: LocalParticipant, didPublish publication: LocalTrackPublication) {
        logEvent("TrackPublished(Participant=\(localParticipant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
    }

    func room(_ room: Room, localParticipant: LocalParticipant, didUnpublish publication: LocalTrackPublication) {
        logEvent("TrackUnpublished(Participant=\(localParticipant.asLog()), Publication=\(publication.asLog()))", roomId: room.name)
    }
}

extension Participant {
    func asLog() -> String {
        switch self {
        case is LocalParticipant: return "Self"
        case is RemoteParticipant: return "Remote(id=\(sid))"
        default: return "Unknown(\(sid))"
        }
    }
}

extension ConnectionQuality {
    var name: String {
        switch self {
        case .excellent: return "excellent"
        case .good: return "good"
        case .poor: return "poor"
        case .unknown: return "unknown"
        }
    }
}

extension ConnectionState {
    func asLog() -> String {
        switch self {
        case .connecting: return "Connecting"
        case .connected: return "Connected"
        case .reconnecting: return "Reconnecting"
        case .disconnected: return "Disconnected"
        }
    }
}

extension TrackPublication {
    func asLog() -> String {
        "TrackPublication(kind=\(kind), id=\(sid))"
    }
}

extension StreamState {
    var name: String {
        switch self {
        case .paused: return "paused"
        case .active: return "active"
        }
    }
}
