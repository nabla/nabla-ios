import Foundation
import UIKit

final class LoadingView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .large)

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)

        activityIndicator.tintColor = CoreAssets.Colors.tint.color
        addSubview(activityIndicator)
        activityIndicator.center(in: self)
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
