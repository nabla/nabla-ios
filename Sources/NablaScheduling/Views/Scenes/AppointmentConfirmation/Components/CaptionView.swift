import NablaCore
import UIKit

extension AppointmentConfirmationViewController {
    final class CaptionView: UIView {
        // MARK: - Internal
        
        var text: String? {
            get { label.text }
            set { label.text = newValue }
        }
        
        // MARK: Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
            updateAppearance()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
            updateAppearance()
        }
        
        // MARK: - Private
        
        // MARK: Life cycle
        
        override func layoutSubviews() {
            super.layoutSubviews()
            updateCaptionShape()
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updateAppearance()
        }
        
        // MARK: Subviews
        
        private lazy var backgroundView: UIView = {
            let view = UIView()
            // `borderColor` managed in `updateAppearance()`
            view.layer.borderWidth = 1
            view.backgroundColor = NablaTheme.AppointmentConfirmationTheme.captionBackgroundColor
            return view
        }()
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView(image: .nabla.symbol(.video))
            view.tintColor = NablaTheme.AppointmentConfirmationTheme.captionTextColor
            view.contentMode = .scaleAspectFit
            view.nabla.constraintToSize(16)
            return view
        }()
        
        private lazy var label: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textColor = NablaTheme.AppointmentConfirmationTheme.captionTextColor
            view.font = NablaTheme.AppointmentConfirmationTheme.captionFont
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
        
        private func updateAppearance() {
            backgroundView.layer.borderColor = NablaTheme.AppointmentConfirmationTheme.captionBorderColor.cgColor
            updateCaptionShape()
        }
        
        private func updateCaptionShape() {
            switch NablaTheme.AppointmentConfirmationTheme.captionShape {
            case .capsule:
                backgroundView.layer.cornerRadius = min(frame.height, frame.width) / 2
            case let .rounderRect(cornerRadius):
                backgroundView.layer.cornerRadius = cornerRadius
            }
        }
    }
}
