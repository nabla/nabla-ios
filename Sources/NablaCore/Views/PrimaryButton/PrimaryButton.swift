import UIKit

public extension NablaViews {
    final class PrimaryButton: UIButton {
        // MARK: - Public
        
        public var theme: Theme = NablaTheme.Button.accent {
            didSet { updateAppearance() }
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
        
        private lazy var loadingIndicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.hidesWhenStopped = true
            return view
        }()
        
        private func setUp() {
            layer.cornerRadius = 8
            
            contentEdgeInsets = .nabla.all(16)
            
            addSubview(loadingIndicator)
            loadingIndicator.nabla.constraintToCenterInSuperView()
            
            addTarget(self, action: #selector(tapHandler), for: .touchUpInside)
        }
        
        private func updateAppearance() {
            titleLabel?.font = theme.font
            loadingIndicator.color = theme.textColor
            setTitleColor(theme.textColor, for: .normal)
            setTitleColor(theme.highlightedTextColor, for: .highlighted)
            setTitleColor(theme.disabledTextColor, for: .disabled)
            
            if isLoading {
                loadingIndicator.startAnimating()
                titleLabel?.alpha = 0
            } else {
                loadingIndicator.stopAnimating()
                titleLabel?.alpha = 1
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
