import UIKit

public extension NablaViews {
    class RefreshingIndicatorView: UIView {
        // MARK: - Internal
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        // MARK: - Private
        
        private lazy var activityIndicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView(style: .medium)
            view.color = NablaTheme.Colors.Stroke.base
            view.startAnimating()
            return view
        }()
        
        private lazy var label: UILabel = {
            let view = UILabel()
            view.text = L10n.refreshingIndicatorLabel
            view.font = NablaTheme.Fonts.bodyMedium
            view.textColor = NablaTheme.Colors.Text.base
            return view
        }()
        
        private func setUp() {
            let hstack = UIStackView(arrangedSubviews: [activityIndicator, label])
            hstack.axis = .horizontal
            hstack.distribution = .fill
            hstack.alignment = .center
            hstack.spacing = 4
            addSubview(hstack)
            hstack.nabla.pinToSuperView()
        }
    }
}
