#if canImport(LiveKitClient)
    import LiveKitClient
#else
    import LiveKit
#endif
import NablaCore
import UIKit

enum TrackState {
    case disconnected
    case connected(VideoTrack)
}

protocol VideoCallRoomViewContract: AnyObject {
    func setMainTrack(_ track: TrackState)
    func setSecondaryTrack(_ track: TrackState?)
    
    func setMicrophoneButton(activated: Bool)
    func setCameraButton(activated: Bool)
    
    func displayError(message: String, action: String, onTap: @escaping () -> Void)
    func hideError()
    
    func close()
    func startPictureInPicture()
    func stopPictureInPicture(completion: (() -> Void)?)
    
    func openSettings()
}

final class VideoCallRoomViewController: UIViewController, VideoCallRoomViewContract {
    // MARK: - Internal
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { .overFullScreen }
        set { assertionFailure("Only overFullScreen is supported, because of Picture-in-picture") }
    }
    
    func setMainTrack(_ track: TrackState) {
        switch track {
        case .disconnected:
            fullScreenVideoView.track = nil
            fullScreenVideoView.isLoading = true
        case let .connected(track):
            fullScreenVideoView.track = track
            fullScreenVideoView.isLoading = false
        }
    }
    
    func setSecondaryTrack(_ track: TrackState?) {
        let visible: Bool
        switch track {
        case .none, .disconnected:
            visible = false
            minitatureVideoView.track = nil
            minitatureVideoView.isLoading = true
        case let .connected(track):
            visible = true
            minitatureVideoView.track = track
            minitatureVideoView.isLoading = false
        }
        minitatureVideoView.isHidden = !visible
    }
    
    func setMicrophoneButton(activated: Bool) {
        microphoneButton.isSelected = activated
    }
    
    func setCameraButton(activated: Bool) {
        cameraButton.isSelected = activated
    }
    
    func displayError(message: String, action: String, onTap: @escaping () -> Void) {
        errorView.message = message
        errorView.action = action
        errorView.onTapAction = onTap
        errorView.isHidden = false
        closeButton.imageColor = .white
        onCloseAction = presenter.userDidTapCloseButtonOnErrorView
    }
    
    func hideError() {
        errorView.isHidden = true
        closeButton.imageColor = .darkText
        onCloseAction = presenter.userDidTapCloseButtonDuringCall
    }
    
    func close() {
        if let pip = pip {
            pip.close(animated: false) { [weak self] in
                self?.performClose(animated: false)
            }
        } else {
            performClose(animated: true)
        }
    }
    
    func startPictureInPicture() {
        guard let pip = PictureInPictureViewController(source: self) else { return }
        let overlay = OverlayWindow(viewController: pip)
        overlay.makeKeyAndVisible()
        
        self.pip = pip
    }
    
    func stopPictureInPicture(completion: (() -> Void)?) {
        pip?.close(animated: true, completion: completion)
    }
    
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: Initializer
    
    init(
        presenter: VideoCallRoomPresenter
    ) {
        self.presenter = presenter
        onCloseAction = presenter.userDidTapCloseButtonDuringCall
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private

    private let presenter: VideoCallRoomPresenter
    
    private var onCloseAction: () -> Void
    private weak var pip: PictureInPictureViewController?
    
    /// `contentView` is used as a global container to be moved to PiP mode.
    private lazy var contentView: UIView = .init()
    
    private lazy var closeButton: ImageButton = {
        let view = makeButton(selector: #selector(closeButtonHandler))
        view.image = .nabla.symbol(.chevronDown)
        view.color = .clear
        return view
    }()
    
    private lazy var microphoneButton: UIControl = {
        let view = makeButton(selector: #selector(microphoneButtonHandler))
        view.image = .nabla.symbol(.microphoneSlash)
        view.selectedImage = .nabla.symbol(.microphone)
        return view
    }()
    
    private lazy var cameraButton: UIControl = {
        let view = makeButton(selector: #selector(cameraButtonHandler))
        view.image = .nabla.symbol(.videoSlash)
        view.selectedImage = .nabla.symbol(.video)
        return view
    }()
    
    private lazy var cameraPositionButton: UIControl = {
        let view = makeButton(selector: #selector(cameraPositionButtonHandler))
        view.image = .nabla.symbol(.rotateCamera)
        view.imageColor = .darkText
        view.color = .white
        return view
    }()
    
    private lazy var hangButton: UIControl = {
        let view = makeButton(selector: #selector(hangButtonHandler))
        view.image = .nabla.symbol(.phoneDownFill)
        view.imageColor = .white
        view.color = .systemRed
        return view
    }()

    private lazy var fullScreenVideoView: VideoTrackView = {
        let view = VideoTrackView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var minitatureVideoView: VideoTrackView = {
        let view = VideoTrackView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.nabla.constraintToSize(CGSize(width: 124, height: 202))
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    private func makeButton(selector: Selector) -> ImageButton {
        let button = ImageButton(imageSize: CGSize(width: 28, height: 28))
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.nabla.constraintToSize(64)
        button.layer.cornerRadius = 32
        button.layer.masksToBounds = true
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(
            navigationController == nil,
            "`VideoCallViewController` inside a `UINavigationController` is not supported. Use `UIViewController.present(_:animated:)` instead."
        )
        
        view.backgroundColor = .white
        setUpSubviews()
        hideError()
        presenter.start()
    }
    
    private func setUpSubviews() {
        // `contentView` is used as a global container to be moved to PiP mode.
        view.addSubview(contentView)
        contentView.nabla.pinToSuperView()
        
        contentView.addSubview(fullScreenVideoView)
        fullScreenVideoView.nabla.pinToSuperView()
        
        let buttonHStack = UIStackView(arrangedSubviews: [
            microphoneButton,
            cameraButton,
            cameraPositionButton,
            hangButton,
        ])
        buttonHStack.axis = .horizontal
        buttonHStack.distribution = .equalSpacing
        buttonHStack.alignment = .center
        buttonHStack.spacing = 24
        
        let footerHStack = UIStackView(arrangedSubviews: [
            UIView(),
            minitatureVideoView,
        ])
        footerHStack.axis = .horizontal
        footerHStack.distribution = .fill
        footerHStack.alignment = .bottom
        footerHStack.spacing = 0
        
        let vstack = UIStackView(arrangedSubviews: [
            footerHStack,
            buttonHStack,
        ])
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.alignment = .fill
        vstack.spacing = 12
        
        contentView.addSubview(vstack)
        vstack.nabla.pin(to: contentView.safeAreaLayoutGuide, edges: [.leading, .bottom, .trailing], insets: .nabla.make(horizontal: 24, vertical: 8))
        
        contentView.addSubview(errorView)
        errorView.nabla.pinToSuperView()
        
        contentView.addSubview(closeButton)
        closeButton.nabla.pin(to: contentView.safeAreaLayoutGuide, edges: [.top, .leading])
    }
    
    @objc private func closeButtonHandler() {
        onCloseAction()
    }
    
    @objc private func microphoneButtonHandler() {
        presenter.userDidTapMicrophoneButton()
    }
    
    @objc private func cameraButtonHandler() {
        presenter.userDidTapCameraButton()
    }
    
    @objc private func cameraPositionButtonHandler() {
        presenter.userDidTapCameraPositionButton()
    }
    
    @objc private func hangButtonHandler() {
        presenter.userDidTapHangButton()
    }
    
    private func performClose(animated: Bool) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            dismiss(animated: animated)
        }
    }
}

extension VideoCallRoomViewController: PictureInPicturePresentable {
    func contentViewForPictureInPictureViewController(_: PictureInPictureViewController) -> UIView {
        contentView
    }
    
    private var viewsToHideInPiP: [UIView] { [
        closeButton,
        microphoneButton,
        cameraButton,
        cameraPositionButton,
        hangButton,
        minitatureVideoView,
    ] }
    
    func pictureInPictureViewController(_: PictureInPictureViewController, willMinimize _: UIView) {
        UIView.animate(withDuration: 0.25) {
            self.viewsToHideInPiP.forEach { $0.alpha = 0 }
        }
    }
    
    func pictureInPictureViewController(_: PictureInPictureViewController, didRestore _: UIView) {
        UIView.animate(withDuration: 0.25) {
            self.viewsToHideInPiP.forEach { $0.alpha = 1 }
        }
    }
}
