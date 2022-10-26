import NablaCore
import UIKit

public extension NablaTheme {
    enum AppointmentConfirmationTheme {
        /// Background color for the appointment confirmation view. Default set to NablaTheme.secondaryBackgroundColor
        public static var backgroundColor = NablaTheme.secondaryBackgroundColor
        /// Background color for the appointment confirmation header view. Default set to NablaTheme.backgroundColor
        public static var headerBackgroundColor = NablaTheme.backgroundColor
        
        /// Color used to display the name of the doctor. Default set to NablaTheme.primaryTextColor
        public static var doctorNameColor = NablaTheme.primaryTextColor
        /// Font used to display the name of the doctor. Default set to Bold(16)
        public static var doctorNameFont = UIFont.nabla.bold(16)
        /// Color used to display details of the doctor. Default set to NablaTheme.darkAlternateTextColor
        public static var doctorDescriptionColor = NablaTheme.darkAlternateTextColor
        /// Font used to display details of the doctor. Default set to NablaTheme.subhead
        public static var doctorDescriptionFont = NablaTheme.subhead
        
        /// Color used to display legal disclaimers of the appointment. Default set to NablaTheme.darkAlternateTextColor
        public static var disclaimersTextColor = NablaTheme.darkAlternateTextColor
        /// Font used to display legal disclaimers of the appointment. Default set to NablaTheme.subhead
        public static var disclaimersFont = NablaTheme.subhead
        
        /// Color used for the text of the cell to display appointment time. Default set to NablaTheme.primaryColor
        public static var captionTintColor = NablaTheme.primaryColor
        /// Color used for background of the cell to display appointment time. Default set to Colors.lightBlue
        public static var captionBackgroundColor: UIColor = Assets.Colors.lightBlue.color
        /// Font used for the text of the cell to display appointment time. Default set to Medium(14)
        public static var captionFont = UIFont.nabla.medium(14)
        
        /// Style of the checkbox for legal disclaimers. Default set to NablaTheme.checkbox
        public static var checkbox = NablaTheme.checkbox
        /// Style of the button to confirm the appointment. Default set to NablaTheme.primaryButton
        public static var button = NablaTheme.primaryButton
    }
}
