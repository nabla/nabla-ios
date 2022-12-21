import NablaCore
import UIKit

final class LoadingButton: UIControl {
    // MARK: - Internal
    
    func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }
    
    func setImage(_ image: UIImage?, for state: UIControl.State) {
        button.setImage(image, for: state)
    }
    
    var isLoading: Bool {
        get { !loadingIndicator.isHidden }
        set {
            loadingIndicator.isHidden = !newValue
            button.isHidden = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        setUpSubviews()
        isLoading = false
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        view.imageView?.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.startAnimating()
        return view
    }()
    
    private func setUpSubviews() {
        addSubview(button)
        button.nabla.pinToSuperView()
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        addSubview(loadingIndicator)
        loadingIndicator.nabla.pinToSuperView()
        loadingIndicator.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    @objc private func buttonHandler() {
        sendActions(for: .touchUpInside)
    }
}
