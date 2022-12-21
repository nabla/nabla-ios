#if canImport(LiveKitClient)
    import LiveKitClient
#else
    import LiveKit
#endif
import NablaCore
import UIKit

class VideoTrackView: UIView {
    // MARK: - Internal
    
    var isLoading: Bool {
        get { spinner.isAnimating }
        set { newValue ? spinner.startAnimating() : spinner.startAnimating() }
    }
    
    var track: VideoTrack? {
        get { liveKitView.track }
        set { liveKitView.track = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubviews()
    }
    
    deinit {
        liveKitView.track = nil // safety net
    }
    
    // MARK: - Private
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.startAnimating()
        return view
    }()
    
    private let liveKitView: VideoView = {
        let view = VideoView()
        return view
    }()
    
    private func setUpSubviews() {
        addSubview(spinner)
        spinner.nabla.pinToSuperView()
        
        addSubview(liveKitView)
        liveKitView.nabla.pinToSuperView()
    }
}
