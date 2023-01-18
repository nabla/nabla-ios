import NablaCore
import UIKit

public final class AppointmentDetailsView: UIView {
    // MARK: - Internal
    
    enum CaptionIcon {
        case video
        case house
    }
    
    var theme: Theme {
        didSet { updateTheme() }
    }
    
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
    
    var captionIcon: CaptionIcon = .video {
        didSet {
            switch captionIcon {
            case .video: captionView.image = .nabla.symbol(.video)
            case .house: captionView.image = .nabla.symbol(.house)
            }
        }
    }
    
    var details1: String? {
        get { details1Label.text }
        set {
            details1Label.text = newValue
            details1Label.isHidden = newValue?.isEmpty ?? true
        }
    }
    
    var details2: String? {
        get { details2Label.text }
        set {
            details2Label.text = newValue
            details2Label.isHidden = newValue?.isEmpty ?? true
        }
    }
    
    var onDetailsTapped: (() -> Void)?
    
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
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var captionView: CaptionView = {
        let view = CaptionView(frame: .zero, theme: theme.caption)
        return view
    }()
    
    private lazy var details1Label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.isHidden = true
        return view
    }()
    
    private lazy var details2Label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.isHidden = true
        return view
    }()
    
    private func setUp() {
        let vstack = UIStackView(arrangedSubviews: [
            avatarView,
            titleLabel,
            subtitleLabel,
            captionView,
            details1Label,
            details2Label,
        ])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .fill
        addSubview(vstack)
        vstack.nabla.pinToSuperView(insets: .nabla.make(horizontal: 8, vertical: 20))
        vstack.setCustomSpacing(12, after: avatarView)
        vstack.setCustomSpacing(4, after: titleLabel)
        vstack.setCustomSpacing(12, after: subtitleLabel)
        vstack.setCustomSpacing(16, after: captionView)
        vstack.setCustomSpacing(12, after: details1Label)
        
        addTapGesture(to: details1Label, action: #selector(detailsTapHandler))
        addTapGesture(to: details2Label, action: #selector(detailsTapHandler))
    }
    
    private func updateTheme() {
        backgroundColor = theme.backgroundColor
        layer.cornerRadius = theme.cornerRadius
        
        titleLabel.textColor = theme.doctorNameColor
        titleLabel.font = theme.doctorNameFont
        
        subtitleLabel.textColor = theme.doctorDescriptionColor
        subtitleLabel.font = theme.doctorDescriptionFont
        
        captionView.theme = theme.caption
        
        details1Label.textColor = theme.addressColor
        details1Label.font = theme.addressFont
        details2Label.textColor = theme.addressExtraColor
        details2Label.font = theme.addressExtraFont
    }
    
    private func addTapGesture(to view: UIView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func detailsTapHandler() {
        onDetailsTapped?()
    }
}
