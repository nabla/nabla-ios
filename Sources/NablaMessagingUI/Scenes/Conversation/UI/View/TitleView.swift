import NablaCore
import UIKit

final class TitleView: UIView {
    // MARK: - Internal
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set {
            subtitleLabel.text = newValue
            subtitleLabel.isHidden = newValue == nil
        }
    }
    
    var avatar: AvatarViewModel {
        get { avatarView.avatar }
        set { avatarView.avatar = newValue }
    }
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setUpSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let avatarSize = CGSize(width: 36, height: 36)
    }
    
    private let avatarView: NablaViews.AvatarView = {
        let view = NablaViews.AvatarView()
        view.nabla.constraintToSize(Constants.avatarSize)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = NablaTheme.Conversation.headerTitleColor
        view.font = NablaTheme.Conversation.headerTitleFont
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.textColor = NablaTheme.Conversation.headerSubtitleColor
        view.font = NablaTheme.Conversation.headerSubtitleFont
        return view
    }()

    private func makeSpacer() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    private func setUpSubviews() {
        let spacer = makeSpacer()
        
        let titleSubtitleVStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleSubtitleVStack.axis = .vertical
        titleSubtitleVStack.alignment = .leading
        titleSubtitleVStack.distribution = .fill
        titleSubtitleVStack.spacing = 3
        
        let hstack = UIStackView(arrangedSubviews: [avatarView, titleSubtitleVStack, spacer])
        hstack.axis = .horizontal
        hstack.alignment = .center
        hstack.distribution = .fill
        hstack.spacing = 8
        addSubview(hstack)
        hstack.nabla.pinToSuperView()
    }
}
