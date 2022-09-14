import NablaCore
import UIKit

public extension NablaTheme {
    enum AppointmentConfirmationTheme {
        public static var backgroundColor = NablaTheme.secondaryBackgroundColor
        public static var headerBackgroundColor = NablaTheme.backgroundColor
        
        public static var doctorNameColor = NablaTheme.primaryTextColor
        public static var doctorNameFont = UIFont.nabla.bold(16)
        public static var doctorDescriptionColor = NablaTheme.darkAlternateTextColor
        public static var doctorDescriptionFont = NablaTheme.subhead
        
        public static var disclaimersTextColor = NablaTheme.darkAlternateTextColor
        public static var disclaimersFont = NablaTheme.subhead
        
        public static var captionTintColor = NablaTheme.primaryColor
        public static var captionBackgroundColor: UIColor = Assets.Colors.lightBlue.color
        public static var captionFont = UIFont.nabla.medium(14)
        
        public static var checkbox = NablaTheme.checkbox
        public static var button = NablaTheme.primaryButton
    }
}
