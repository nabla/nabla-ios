import Foundation
import UIKit

final class LoadingView: UIView {
    // MARK: - Initializer
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        activityIndicator.tintColor = NablaTheme.LoadingView.tintColor
        addSubview(activityIndicator)
        activityIndicator.center(in: self)
    }
    
    // MARK: - Public
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    // MARK: - Private
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
}
