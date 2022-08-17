import Foundation

protocol VideoCallRoomPresenter: AnyObject {
    func start()
    func userDidTapCloseButtonDuringCall()
    func userDidTapCloseButtonOnErrorView()
    func userDidTapMicrophoneButton()
    func userDidTapCameraButton()
    func userDidTapCameraPositionButton()
    func userDidTapHangButton()
}
