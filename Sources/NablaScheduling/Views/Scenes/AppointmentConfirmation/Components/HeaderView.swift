import NablaCore
import UIKit

extension AppointmentConfirmationViewController {
    final class HeaderView: UIView {
        // MARK: - Internal
        
        var avatar: AvatarViewModel {
            get { avatarView.avatar }
            set { avatarView.avatar = newValue }
        }
        
        var title: String? {
            get { titleLabel.text }
            set { titleLabel.text = newValue }
        }
        
        var subtitle: String? {
            get { subtitleLabel.text }
            set { subtitleLabel.text = newValue }
        }
        
        var caption: String? {
            get { captionView.text }
            set { captionView.text = newValue }
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
        
        // MARK: Subviews
        
        private lazy var avatarView: NablaViews.AvatarView = {
            let view = NablaViews.AvatarView()
            view.nabla.constraintToSize(72)
            return view
        }()
        
        private lazy var titleLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textAlignment = .center
            view.textColor = NablaTheme.AppointmentConfirmationTheme.doctorNameColor
            view.font = NablaTheme.AppointmentConfirmationTheme.doctorNameFont
            return view
        }()
        
        private lazy var subtitleLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textAlignment = .center
            view.textColor = NablaTheme.AppointmentConfirmationTheme.doctorDescriptionColor
            view.font = NablaTheme.AppointmentConfirmationTheme.doctorDescriptionFont
            return view
        }()
        
        private lazy var captionView: CaptionView = {
            let view = CaptionView()
            return view
        }()
        
        private func setUp() {
            backgroundColor = NablaTheme.AppointmentConfirmationTheme.headerBackgroundColor
            layer.cornerRadius = 12
            
            let vstack = UIStackView(arrangedSubviews: [avatarView, titleLabel, subtitleLabel, captionView])
            vstack.axis = .vertical
            vstack.alignment = .center
            vstack.distribution = .fill
            addSubview(vstack)
            vstack.nabla.pinToSuperView(insets: .nabla.make(horizontal: 8, vertical: 20))
            vstack.setCustomSpacing(12, after: avatarView)
            vstack.setCustomSpacing(4, after: titleLabel)
            vstack.setCustomSpacing(12, after: subtitleLabel)
        }
    }
}
