import Foundation
import NablaCore
import UIKit

private enum Constants {
    static let avatarSize: CGFloat = 44
    static let unreadIndicatorSize: CGFloat = 8
}

class ConversationListItemCell: UITableViewCell, Reusable {
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with viewModel: ConversationListItemViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        timeLabel.text = viewModel.lastUpdatedTime
        unreadIndicatorView.isHidden = !viewModel.isUnread
        avatarView.avatar = viewModel.avatar
        titleLabel.font = viewModel.isUnread ? NablaTheme.ConversationPreview.previewUnreadTitleFont : NablaTheme.ConversationPreview.previewTitleFont
        subtitleLabel.font = viewModel.isUnread ? NablaTheme.ConversationPreview.previewUnreadSubtitleFont : NablaTheme.ConversationPreview.previewSubtitleFont
    }
    
    // MARK: - Private
    
    private lazy var avatarView: NablaViews.AvatarView = createAvatarView()
    private lazy var titleLabel: UILabel = createTitleLabel()
    private lazy var subtitleLabel: UILabel = createSubtitleLabel()
    private lazy var timeLabel: UILabel = createTimeLabel()
    private lazy var unreadIndicatorView: UIView = createUnreadIndicatorView()
    
    private func setUp() {
        contentView.backgroundColor = NablaTheme.ConversationPreview.previewBackgroundColor
        contentView.addSubview(avatarView)
        avatarView.nabla.pinToSuperView(edges: .leading, insets: .nabla.only(leading: 16))
        avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        avatarView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        contentView.addSubview(timeLabel)
        timeLabel.nabla.pinToSuperView(edges: [.trailing], insets: .nabla.only(trailing: 16))
        timeLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        contentView.addSubview(unreadIndicatorView)
        unreadIndicatorView.nabla.pinToSuperView(edges: .trailing, insets: .nabla.only(trailing: 16))
        unreadIndicatorView.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor).isActive = true
    }
    
    private func createAvatarView() -> NablaViews.AvatarView {
        let avatarView = NablaViews.AvatarView()
        avatarView.nabla.constraintToSize(CGSize(width: Constants.avatarSize, height: Constants.avatarSize))
        return avatarView
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.ConversationPreview.previewTitleColor
        return label
    }
    
    private func createSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.ConversationPreview.previewSubtitleColor
        return label
    }
    
    private func createTimeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.ConversationPreview.previewTimeLabelColor
        label.font = NablaTheme.ConversationPreview.previewTimeLabelFont
        return label
    }
    
    private func createUnreadIndicatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.ConversationPreview.previewUnreadIndicatorColor
        view.nabla.constraintToSize(CGSize(width: Constants.unreadIndicatorSize, height: Constants.unreadIndicatorSize))
        view.layer.cornerRadius = Constants.unreadIndicatorSize / 2
        view.clipsToBounds = true
        return view
    }
}
