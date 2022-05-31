import UIKit

final class TitleView: UIView {
    // MARK: - Internal
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var avatar: AvatarViewModel = .init(url: nil, text: nil) {
        didSet { avatarView.configure(with: avatar) }
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
    
    private let avatarView: AvatarView = {
        let view = AvatarView()
        view.constraintToSize(Constants.avatarSize)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = NablaTheme.ConversationPreview.previewTitleColor
        view.font = NablaTheme.ConversationPreview.previewTitleFont
        return view
    }()
    
    private func makeSpacer() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    private func setUpSubviews() {
        let spacer = makeSpacer()
        let hstack = UIStackView(arrangedSubviews: [avatarView, titleLabel, spacer])
        hstack.axis = .horizontal
        hstack.alignment = .center
        hstack.distribution = .fill
        hstack.spacing = 8
        addSubview(hstack)
        hstack.pinToSuperView()
    }
}
