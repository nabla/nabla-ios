import UIKit

public extension NablaViews {
    final class PrimaryButton: UIControl {
        // MARK: - Public
        
        public var theme: Theme = NablaTheme.primaryButton {
            didSet { updateAppearance() }
        }
        
        public var title: String? {
            get { titleLabel.text }
            set { titleLabel.text = newValue }
        }
        
        public var onTap: (() -> Void)?
        
        public var isLoading = false {
            didSet { updateAppearance() }
        }
        
        override public var isEnabled: Bool {
            didSet { updateAppearance() }
        }
        
        override public var isHighlighted: Bool {
            didSet { updateAppearance() }
        }
        
        // MARK: Init
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
            updateAppearance()
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
            updateAppearance()
        }
        
        // MARK: - Private
        
        // MARK: Subviews
        
        private lazy var titleLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 1
            view.textAlignment = .center
            return view
        }()
        
        private lazy var loadingIndicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.hidesWhenStopped = true
            return view
        }()
        
        private func setUp() {
            layer.cornerRadius = 8
            nabla.constraintHeight(52)
            
            addSubview(titleLabel)
            titleLabel.nabla.constraintToCenterInSuperView()
            titleLabel.nabla.pinToSuperView(edges: .nabla.horizontal, insets: .nabla.horizontal(16))
            
            addSubview(loadingIndicator)
            loadingIndicator.nabla.constraintToCenterInSuperView()
            
            addTarget(self, action: #selector(tapHandler), for: .touchUpInside)
        }
        
        private func updateAppearance() {
            backgroundColor = theme.backgroundColor
            titleLabel.textColor = theme.textColor
            titleLabel.font = theme.font
            loadingIndicator.color = theme.textColor
            
            if isLoading {
                loadingIndicator.startAnimating()
                titleLabel.isHidden = true
            } else {
                loadingIndicator.stopAnimating()
                titleLabel.isHidden = false
            }
            
            UIView.animate(withDuration: 0.2) { [self] in
                if state.contains(.disabled) {
                    backgroundColor = theme.disabledBackgroundColor
                } else if state.contains(.highlighted) {
                    backgroundColor = theme.highlightedBackgroundColor
                
                } else {
                    backgroundColor = theme.backgroundColor
                }
            }
        }
        
        @objc private func tapHandler() {
            onTap?()
        }
    }
}
