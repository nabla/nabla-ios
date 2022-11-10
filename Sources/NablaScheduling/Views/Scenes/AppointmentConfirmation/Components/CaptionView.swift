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
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        // MARK: - Private
        
        // MARK: Life cycle
        
        override func layoutSubviews() {
            super.layoutSubviews()
            backgroundView.layer.cornerRadius = min(frame.height, frame.width) / 2
        }
        
        // MARK: Subviews
        
        private lazy var backgroundView: UIView = {
            let view = UIView()
            view.layer.borderWidth = 1
            view.layer.borderColor = NablaTheme.AppointmentConfirmationTheme.captionBorderColor.cgColor
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
    }
}
