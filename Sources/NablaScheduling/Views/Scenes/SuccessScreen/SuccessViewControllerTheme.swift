import NablaCore
import UIKit

public extension NablaTheme {
    enum SuccessTheme {
        /// Background color for the view.
        static var backgroundColor: UIColor = Colors.Background.base
        
        /// Color for the image.
        static var imageColor: UIColor = Colors.Text.subdued
        
        /// Color for the text.
        static var messageColor: UIColor = Colors.Text.subdued
        /// Font for the text.
        static var messageFont: UIFont = Fonts.subtitleMedium
        
        /// Theme for the button.
        static var button: NablaViews.PrimaryButton.Theme = NablaTheme.Button.accent
    }
}
