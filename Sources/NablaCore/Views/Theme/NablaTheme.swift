import Foundation
import UIKit

/// This struct is used to configure the theme of the app. You can use the default values if needed or
/// override one or many.
///
/// This is divided in two sections:
/// - First are the top level values, those are the primary configurations, used in all of the screens,
/// updating one inpact all of the app
/// - Then you have the sub structs. Those rely on the top level values but offer a fine tune configuration for each element of
/// the SDK.
public enum NablaTheme {
    // MARK: - Colors
    
    public static var primaryColor: UIColor = Assets.Colors.primary.color
    public static var lightPrimaryColor: UIColor = Assets.Colors.lightPrimary.color
    public static var backgroundColor: UIColor = Assets.Colors.background.color
    public static var primaryTextColor: UIColor = Assets.Colors.primaryText.color
    public static var secondaryTextColor: UIColor = Assets.Colors.secondaryText.color
    public static var alternateTextColor: UIColor = Assets.Colors.alternateText.color
    public static var lightAlternateTextColor: UIColor = Assets.Colors.lightAlternateTextColor.color
    public static var darkAlternateTextColor: UIColor = Assets.Colors.darkAlternateTextColor.color
    public static var secondaryBackgroundColor: UIColor = Assets.Colors.secondaryBackground.color
    public static var accessoryColor: UIColor = Assets.Colors.accessory.color
    
    // MARK: - Fonts
    
    public static var largeTitle = UIFont.nabla.regular(33)
    public static var title1 = UIFont.nabla.regular(27)
    public static var title2 = UIFont.nabla.regular(21)
    public static var title3 = UIFont.nabla.regular(19)
    public static var headline = UIFont.nabla.semiBold(18)
    public static var body = UIFont.nabla.regular(16)
    public static var bodyMedium = UIFont.nabla.medium(16)
    public static var bodyItalic = UIFont.nabla.italic(16)
    public static var callout = UIFont.nabla.regular(15)
    public static var subhead = UIFont.nabla.regular(14)
    public static var footnote = UIFont.nabla.regular(12)
    public static var caption1 = UIFont.nabla.regular(11)
    public static var caption2 = UIFont.nabla.regular(10)
    
    // MARK: - Components
    
    public static var primaryButton = NablaViews.PrimaryButton.Theme()
    public static var checkbox = NablaViews.CheckboxView.Theme()

    public enum Shared {
        /// Tint color used for the loading indicator. Default set to NablaTheme.primaryColor
        public static var loadingViewIndicatorTintColor = NablaTheme.primaryColor

        /// Background color used to display the avatar of someone who doesn't have a profile picture. Default set to NablaTheme.primaryColor
        public static var avatarViewBackgroundColor = NablaTheme.primaryColor
    }
}
