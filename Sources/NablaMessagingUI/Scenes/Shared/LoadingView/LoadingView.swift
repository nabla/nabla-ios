import Foundation
import NablaCore
import UIKit

final class LoadingView: UIView {
    // MARK: - Initializer
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        activityIndicator.tintColor = NablaTheme.Shared.loadingViewIndicatorTintColor
        addSubview(activityIndicator)
        activityIndicator.nabla.constraintToCenterInSuperView()
    }
    
    // MARK: - Public
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    // MARK: - Private
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        return view
    }()
}
