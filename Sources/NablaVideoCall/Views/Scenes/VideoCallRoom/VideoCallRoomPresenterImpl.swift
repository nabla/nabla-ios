import AVFoundation
import Foundation
import LiveKit
import NablaCore

final class VideoCallRoomPresenterImpl: VideoCallRoomPresenter {
    // MARK: - Internal
    
    struct Dependencies {
        let currentVideoCallInteractor: CurrentVideoCallInteractor
        let logger: Logger
    }
    
    func bind(to view: VideoCallRoomViewContract) {
        self.view = view
    }
    
    func start() {
        dependencies.currentVideoCallInteractor.becomeCurrentVideoCall(token: token, reopen: { [weak self] in
            self?.view?.stopPictureInPicture(completion: nil)
        })
        
        updateParticipants()
        updateLocalUserState()
        requestPermissions { [weak self] authorized in
            if authorized {
                self?.connectToRoom()
            } else {
                self?.displayPermissionsDeniedError()
            }
        }
    }
    
    func userDidTapCloseButtonDuringCall() {
        view?.startPictureInPicture()
    }
    
    func userDidTapCloseButtonOnErrorView() {
        close()
    }
    
    func userDidTapMicrophoneButton() {
        guard let localUser = localUser else { return }
        let isEnabled = localUser.participant.isMicrophoneEnabled()
        localUser.participant.setMicrophone(enabled: !isEnabled)
            .then { _ in self.updateLocalUserState() }
    }
    
    func userDidTapCameraButton() {
        guard let localUser = localUser else { return }
        let isEnabled = localUser.participant.isCameraEnabled()
        localUser.participant.setCamera(enabled: !isEnabled)
            .then { _ in
                self.updateLocalUserState()
                self.updateParticipants()
            }
    }
    
    func userDidTapCameraPositionButton() {
        localUser?.camera?.switchCameraPosition()
    }
    
    func userDidTapHangButton() {
        close()
    }
    
    deinit {
        _ = room?.disconnect()
    }
    
    // MARK: Initializer
    
    init(
        url: String,
        token: String,
        dependencies: Dependencies
    ) {
        self.url = url
        self.token = token
        self.dependencies = dependencies
    }
    
    // MARK: - Private
    
    private let url: String
    private let token: String
    private let dependencies: Dependencies
    
    private var room: Room?
    private weak var view: VideoCallRoomViewContract?
    
    private var localUser: LocalUser? {
        didSet {
            updateLocalUserState()
            updateParticipants()
        }
    }
    
    private var remoteUser: RemoteUser? {
        didSet { updateParticipants() }
    }
    
    private func close() {
        view?.close()
        dependencies.currentVideoCallInteractor.resignCurrentVideoCall()
    }
    
    private func connectToRoom() {
        let room = Room(delegate: self)
        room.connect(url, token).then { [weak self] room in
            self?.room = room
            
            // Publish camera & mic
            room.localParticipant?.setCamera(enabled: true)
                .then { [weak self] _ in self?.updateLocalUserState() }
            room.localParticipant?.setMicrophone(enabled: true)
                .then { [weak self] _ in self?.updateLocalUserState() }

        }.catch { [weak self] _ in
            self?.displayFailedToConnectError()
        }
    }
    
    private func updateParticipants() {
        let remoteTrack = remoteUser?.getVideoTrack()
        let localTrack = localUser?.getVideoTrack()
        if let remoteTrack = remoteTrack, let localTrack = localTrack {
            view?.setMainTrack(.connected(remoteTrack))
            view?.setSecondaryTrack(.connected(localTrack))
        } else if let remoteTrack = remoteTrack {
            view?.setMainTrack(.connected(remoteTrack))
            view?.setSecondaryTrack(.disconnected)
        } else if let localTrack = localTrack {
            view?.setMainTrack(.connected(localTrack))
            view?.setSecondaryTrack(nil)
        } else {
            view?.setMainTrack(.disconnected)
            view?.setSecondaryTrack(nil)
        }
    }
    
    private func updateLocalUserState() {
        view?.setCameraButton(activated: localUser?.participant.isCameraEnabled() ?? false)
        view?.setMicrophoneButton(activated: localUser?.participant.isMicrophoneEnabled() ?? false)
    }
    
    private func requestPermissions(completion: @escaping (Bool) -> Void) {
        guard
            Bundle.main.nabla.hasMicrophoneUsageDescription,
            Bundle.main.nabla.hasCameraUsageDescription
        else {
            let message = "You must set `NSMicrophoneUsageDescription` and `NSCameraUsageDescription` in your plist before asking for the user's permissions"
            dependencies.logger.error(message: message)
            assertionFailure(message)
            completion(false)
            return
        }
        Self.requestPermission(media: .audio) { authorized in
            guard authorized else { return completion(false) }
            Self.requestPermission(media: .video, completion: completion)
        }
    }
    
    private static func requestPermission(media: AVMediaType, completion: @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: media) == .authorized {
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: media) { authorized in
                DispatchQueue.main.async { completion(authorized) }
            }
        }
    }
    
    private func displayPermissionsDeniedError() {
        view?.displayError(
            message: L10n.permissionsDeniedErrorMessage,
            action: L10n.permissionsDeniedErrorAction,
            onTap: { [weak self] in
                self?.view?.openSettings()
            }
        )
    }
    
    private func displayFailedToConnectError() {
        view?.displayError(
            message: L10n.failedToConnectErrorMessage,
            action: L10n.failedToConnectErrorAction,
            onTap: { [weak self] in
                self?.view?.hideError()
                self?.connectToRoom()
            }
        )
    }
    
    private func closeRoomRemotely() {
        DispatchQueue.main.async {
            self.close()
        }
    }
}

extension VideoCallRoomPresenterImpl: RoomDelegate {
    func room(_: Room, localParticipant: LocalParticipant, didPublish publication: LocalTrackPublication) {
        var localUser = self.localUser ?? LocalUser(participant: localParticipant)
        if let videoTrack = publication.track as? LocalVideoTrack {
            localUser.videoTrack = videoTrack
        } else if let audioTrack = publication.track as? LocalAudioTrack {
            localUser.audioTrack = audioTrack
        }
        DispatchQueue.main.async { self.localUser = localUser }
    }
    
    func room(_: Room, participant: RemoteParticipant, didSubscribe _: RemoteTrackPublication, track: Track) {
        var remoteUser = self.remoteUser ?? RemoteUser(participant: participant)
        if let videoTrack = track as? VideoTrack {
            remoteUser.videoTrack = videoTrack
        } else if let audioTrack = track as? AudioTrack {
            remoteUser.audioTrack = audioTrack
        }
        DispatchQueue.main.async { self.remoteUser = remoteUser }
    }
    
    func room(_: Room, participant: RemoteParticipant, didUnpublish publication: RemoteTrackPublication) {
        var remoteUser = self.remoteUser ?? RemoteUser(participant: participant)
        if publication.track is VideoTrack {
            remoteUser.videoTrack = nil
        } else if publication.track is AudioTrack {
            remoteUser.audioTrack = nil
        }
        DispatchQueue.main.async { self.remoteUser = remoteUser }
    }
    
    func room(_: Room, didDisconnect error: Error?) {
        if error == nil {
            closeRoomRemotely()
        } else {
            displayFailedToConnectError()
        }
    }
    
    func room(_: Room, participantDidLeave _: RemoteParticipant) {
        DispatchQueue.main.async {
            self.remoteUser = nil
        }
    }
    
    func room(_: Room, didUpdate connectionState: ConnectionState, oldValue: ConnectionState) {
        switch (oldValue, connectionState) {
        case (.connected, .disconnected):
            closeRoomRemotely()
        default:
            break
        }
    }
    
    func room(_: Room, participant: Participant, didUpdate publication: TrackPublication, muted: Bool) {
        if let localParticipant = participant as? LocalParticipant {
            var localUser = localUser ?? LocalUser(participant: localParticipant)
            if publication.track is VideoTrack {
                localUser.videoMuted = muted
            } else if publication.track is AudioTrack {
                localUser.audioMuted = muted
            }
            DispatchQueue.main.async { self.localUser = localUser }
        } else if let remoteParticipant = participant as? RemoteParticipant {
            var remoteUser = remoteUser ?? RemoteUser(participant: remoteParticipant)
            if publication.track is VideoTrack {
                remoteUser.videoMuted = muted
            } else if publication.track is AudioTrack {
                remoteUser.audioMuted = muted
            }
            DispatchQueue.main.async { self.remoteUser = remoteUser }
        }
    }
}

private protocol User {
    func getVideoTrack() -> VideoTrack?
}

private struct LocalUser: User {
    let participant: LocalParticipant
    var videoTrack: LocalVideoTrack?
    var videoMuted: Bool = false
    var audioTrack: LocalAudioTrack?
    var audioMuted: Bool = false
    
    var camera: CameraCapturer? {
        videoTrack?.capturer as? CameraCapturer
    }
    
    func getVideoTrack() -> VideoTrack? {
        videoMuted ? nil : videoTrack
    }
}

private struct RemoteUser: User {
    let participant: RemoteParticipant
    var videoTrack: VideoTrack?
    var videoMuted: Bool = false
    var audioTrack: AudioTrack?
    var audioMuted: Bool = false
    
    func getVideoTrack() -> VideoTrack? {
        videoMuted ? nil : videoTrack
    }
}
