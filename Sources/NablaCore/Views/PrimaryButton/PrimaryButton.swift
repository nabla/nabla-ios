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
        
        private var backgroundAlreadySet = false
        
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
            
            let targetBackgroundColor: UIColor
            if state.contains(.disabled) {
                targetBackgroundColor = theme.disabledBackgroundColor
            } else if state.contains(.highlighted) {
                targetBackgroundColor = theme.highlightedBackgroundColor
            } else {
                targetBackgroundColor = theme.backgroundColor
            }
            
            if targetBackgroundColor != backgroundColor {
                if backgroundAlreadySet { // Animate only after the first background color change
                    UIView.animate(withDuration: 0.2) { [self] in
                        backgroundColor = targetBackgroundColor
                    }
                } else {
                    backgroundAlreadySet = true
                    backgroundColor = targetBackgroundColor
                }
            }
        }
        
        @objc private func tapHandler() {
            onTap?()
        }
    }
}
