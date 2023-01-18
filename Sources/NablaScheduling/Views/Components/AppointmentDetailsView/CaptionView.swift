import NablaCore
import UIKit

public extension AppointmentDetailsView {
    final class CaptionView: UIView {
        // MARK: - Internal
        
        var theme: Theme {
            didSet { updateTheme() }
        }
        
        var text: String? {
            get { label.text }
            set { label.text = newValue }
        }
        
        var image: UIImage? {
            get { imageView.image }
            set { imageView.image = newValue }
        }
        
        // MARK: Init
        
        init(frame: CGRect, theme: Theme) {
            self.theme = theme
            super.init(frame: frame)
            setUp()
            updateTheme()
        }
        
        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Private
        
        // MARK: Life cycle
        
        override public func layoutSubviews() {
            super.layoutSubviews()
            updateCaptionShape()
        }
        
        override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updateTheme()
        }
        
        // MARK: Subviews
        
        private lazy var backgroundView: UIView = {
            let view = UIView()
            // `borderColor` managed in `updateAppearance()`
            view.layer.borderWidth = 1
            return view
        }()
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.nabla.constraintToSize(16)
            return view
        }()
        
        private lazy var label: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.setContentCompressionResistancePriority(.required, for: .horizontal)
            view.textAlignment = .center
            return view
        }()
        
        private func setUp() {
            let hstack = UIStackView(arrangedSubviews: [imageView, label])
            hstack.axis = .horizontal
            hstack.distribution = .fill
            hstack.alignment = .center
            hstack.spacing = 4
            
            backgroundView.addSubview(hstack)
            hstack.nabla.pinToSuperView(insets: .nabla.make(horizontal: 8, vertical: 6))
            
            addSubview(backgroundView)
            backgroundView.nabla.pinToSuperView()
        }
        
        private func updateTheme() {
            backgroundView.layer.borderColor = theme.borderColor.cgColor
            backgroundView.backgroundColor = theme.backgroundColor
            
            label.textColor = theme.textColor
            label.font = theme.font
            
            imageView.tintColor = theme.textColor
            
            updateCaptionShape()
        }
        
        private func updateCaptionShape() {
            switch theme.shape {
            case .capsule:
                backgroundView.layer.cornerRadius = min(frame.height, frame.width) / 2
            case let .rounderRect(cornerRadius):
                backgroundView.layer.cornerRadius = cornerRadius
            }
        }
    }
}
