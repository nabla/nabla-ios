import Foundation
import NablaCore
import UIKit

public enum NablaTheme {
    // MARK: - Colors

    public static var primaryColor = CoreAssets.Colors.primary.color
    public static var backgroundColor = CoreAssets.Colors.background.color
    public static var primaryTextColor = CoreAssets.Colors.primaryText.color
    public static var secondaryTextColor = CoreAssets.Colors.secondaryText.color
    public static var alternateTextColor = CoreAssets.Colors.alternateText.color
    public static var secondaryBackgroundColor = CoreAssets.Colors.secondaryBackground.color
    public static var accessoryColor = CoreAssets.Colors.accessory.color

    // MARK: - Fonts

    public static var largeTitle = UIFont.regular(33)
    public static var title1 = UIFont.regular(27)
    public static var title2 = UIFont.regular(21)
    public static var title3 = UIFont.regular(19)
    public static var headline = UIFont.semiBold(18)
    public static var body = UIFont.regular(16)
    public static var bodyItalic = UIFont.italic(16)
    public static var callout = UIFont.regular(15)
    public static var subhead = UIFont.regular(14)
    public static var footnote = UIFont.regular(12)
    public static var caption1 = UIFont.regular(11)
    public static var caption2 = UIFont.regular(10)

    // MARK: - Components

    public enum ConversationListItemCell {
        public static var backgroundColor = NablaTheme.backgroundColor
        public static var titleColor = NablaTheme.primaryTextColor
        public static var subtitleColor = NablaTheme.secondaryTextColor
        public static var timeLabelColor = NablaTheme.secondaryTextColor
        public static var unreadIndicatorColor = NablaTheme.primaryColor

        public static var titleFont = NablaTheme.body
        public static var subtitleFont = NablaTheme.subhead
        public static var timeLabelFont = NablaTheme.footnote
    }
    
    public enum ComposerView {
        public static var backgroundColor = NablaTheme.backgroundColor
        public static var accessoryColor = NablaTheme.accessoryColor
        public static var textColor = NablaTheme.primaryTextColor

        public static var font = NablaTheme.body

        public static var sendIcon = UIImage(systemName: "arrow.up.circle.fill")
        public static var addMediaIcon = UIImage(systemName: "camera.on.rectangle")
    }

    public enum TextMessageContentView {
        public static var meTextColor = NablaTheme.alternateTextColor
        public static var themTextColor = NablaTheme.primaryTextColor

        public static var font = NablaTheme.body
    }

    public enum DeletedMessageContentView {
        public static var borderColor = NablaTheme.secondaryTextColor
        public static var backgroundColor = NablaTheme.backgroundColor
        public static var textColor = NablaTheme.secondaryTextColor

        public static var font = NablaTheme.bodyItalic
    }

    public enum ConversationMessageCell {
        public static var cornerRadius: CGFloat = 16
        public static var meBackgroundColor = NablaTheme.primaryColor
        public static var themBackgroundColor = NablaTheme.secondaryBackgroundColor
        public static var authorLabelColor = NablaTheme.secondaryTextColor

        public static var authorLabelFont = NablaTheme.footnote
        public static var footerLabelFont = NablaTheme.footnote
    }

    public enum ConversationViewController {
        public static var backgroundColor = NablaTheme.backgroundColor
    }

    public enum ConversationListView {
        public static var backgroundColor = NablaTheme.backgroundColor
    }

    public enum LoadingView {
        public static var tintColor = NablaTheme.primaryColor
    }

    public enum AvatarView {
        public static var backgroundColor = NablaTheme.primaryColor
    }

    public enum TypingIndicatorView {
        public static var dotColor = NablaTheme.primaryColor
    }
}
