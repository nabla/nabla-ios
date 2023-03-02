import Foundation
import UIKit

/// This struct is used to configure the theme of the app. You can use the default values if needed or
/// override one or many.
///
/// This is divided in two sections:
/// - First are the top level values, those are the primary configurations, used in all of the screens,
/// updating one impacts all of the app
/// - Then you have the sub structs. Those rely on the top level values but offer a fine tune configuration for each element of
/// the SDK.
public enum NablaTheme {
    // MARK: - Fonts
    
    public enum Fonts {
        public static var title = UIFont.nabla.bold(30)
        public static var subtitleBold = UIFont.nabla.bold(16)
        public static var subtitleMedium = UIFont.nabla.medium(16)
        public static var caption = UIFont.nabla.regular(16)
        public static var bodyBold = UIFont.nabla.bold(14)
        public static var bodyMedium = UIFont.nabla.medium(14)
        public static var bodyItalic = UIFont.nabla.italic(14)
        public static var body = UIFont.nabla.regular(14)
        public static var smallMedium = UIFont.nabla.medium(12)
        public static var smallText = UIFont.nabla.regular(12)
    }
    
    // MARK: - Components
    
    public enum Button {
        public static var base = NablaViews.PrimaryButton.Theme(
            backgroundColor: Colors.ButtonBackground.base,
            highlightedBackgroundColor: Colors.ButtonBackground.baseHighlighted,
            disabledBackgroundColor: Colors.ButtonBackground.baseDisabled,
            textColor: Colors.ButtonText.onBase,
            highlightedTextColor: Colors.ButtonText.onBaseHighlighted,
            disabledTextColor: Colors.ButtonText.onBaseDisabled,
            font: Fonts.subtitleMedium,
            cornerRadius: 8
        )
        
        public static var accent = NablaViews.PrimaryButton.Theme(
            backgroundColor: Colors.ButtonBackground.accent,
            highlightedBackgroundColor: Colors.ButtonBackground.accentHighlighted,
            disabledBackgroundColor: Colors.ButtonBackground.accentDisabled,
            textColor: Colors.ButtonText.onAccent,
            highlightedTextColor: Colors.ButtonText.onAccentHighlighted,
            disabledTextColor: Colors.ButtonText.onAccentDisabled,
            font: Fonts.subtitleMedium,
            cornerRadius: 8
        )
        
        public static var accentSubdued = NablaViews.PrimaryButton.Theme(
            backgroundColor: Colors.ButtonBackground.accentSubdued,
            highlightedBackgroundColor: Colors.ButtonBackground.accentSubduedHighlighted,
            disabledBackgroundColor: Colors.ButtonBackground.accentSubduedDisabled,
            textColor: Colors.ButtonText.onAccentSubdued,
            highlightedTextColor: Colors.ButtonText.onAccentSubduedHighlighted,
            disabledTextColor: Colors.ButtonText.onAccentSubduedDisabled,
            font: Fonts.subtitleMedium,
            cornerRadius: 8
        )
        
        public static var danger = NablaViews.PrimaryButton.Theme(
            backgroundColor: .clear,
            highlightedBackgroundColor: .clear,
            disabledBackgroundColor: .clear,
            textColor: Colors.ButtonText.danger,
            highlightedTextColor: Colors.ButtonText.dangerHighlighted,
            disabledTextColor: Colors.ButtonText.dangerDisabled,
            font: Fonts.subtitleMedium,
            cornerRadius: 8
        )
    }
    
    public enum Checkbox {
        public static var base = NablaViews.CheckboxView.Theme(
            tintColor: Colors.Text.onAccent,
            checked: .init(
                borderColor: Colors.Fill.accent,
                fillColor: Colors.Stroke.accent
            ),
            unchecked: .init(
                borderColor: Colors.Stroke.subdued,
                fillColor: .clear
            )
        )
    }

    public enum AvatarView {
        /// Background color used to display the avatar of someone who doesn't have a profile picture.
        public static var backgroundColor = Colors.Fill.base

        /// Color used to tint the initials or the default icon in the avatar of someone who doesn't have a profile picture.
        public static var tintColor = Colors.Text.subdued

        /// Default image used in the avatar view when we don't have a profile picture nor the initials.
        public static var defaultIcon = UIImage(systemName: "person")
    }

    public enum Shared {
        /// Tint color used for the loading indicator.
        public static var loadingViewIndicatorTintColor = Colors.Stroke.accent
    }
}
