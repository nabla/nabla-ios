import Foundation
import UIKit

private enum Constants {
    static let avatarSize: CGFloat = 48
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
        subtitleLabel.text = viewModel.lastMessage
        timeLabel.text = viewModel.lastUpdatedTime
        unreadIndicatorView.isHidden = !viewModel.isUnread
        avatarView.configure(with: viewModel.avatar)
    }
    
    // MARK: - Private
    
    private lazy var avatarView: AvatarView = createAvatarView()
    private lazy var titleLabel: UILabel = createTitleLabel()
    private lazy var subtitleLabel: UILabel = createSubtitleLabel()
    private lazy var timeLabel: UILabel = createTimeLabel()
    private lazy var unreadIndicatorView: UIView = createUnreadIndicatorView()
    
    private func setUp() {
        contentView.backgroundColor = NablaTheme.ConversationListItemCell.backgroundColor
        contentView.addSubview(avatarView)
        avatarView.pinToSuperView(edges: .leading, insets: .only(leading: 16))
        avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        avatarView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 0.0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        contentView.addSubview(timeLabel)
        timeLabel.pinToSuperView(edges: [.top, .trailing], insets: .all(16))
        
        timeLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        contentView.addSubview(unreadIndicatorView)
        unreadIndicatorView.pinToSuperView(edges: .trailing, insets: .only(trailing: 16))
        unreadIndicatorView.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor).isActive = true
    }
    
    private func createAvatarView() -> AvatarView {
        let avatarView = AvatarView()
        avatarView.constraintToSize(CGSize(width: Constants.avatarSize, height: Constants.avatarSize))
        return avatarView
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.ConversationListItemCell.titleColor
        label.font = NablaTheme.ConversationListItemCell.titleFont
        return label
    }
    
    private func createSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.ConversationListItemCell.subtitleColor
        label.font = NablaTheme.ConversationListItemCell.subtitleFont
        return label
    }
    
    private func createTimeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = NablaTheme.ConversationListItemCell.timeLabelColor
        label.font = NablaTheme.ConversationListItemCell.timeLabelFont
        return label
    }
    
    private func createUnreadIndicatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.ConversationListItemCell.unreadIndicatorColor
        view.constraintToSize(CGSize(width: Constants.unreadIndicatorSize, height: Constants.unreadIndicatorSize))
        view.layer.cornerRadius = Constants.unreadIndicatorSize / 2
        view.clipsToBounds = true
        return view
    }
}
