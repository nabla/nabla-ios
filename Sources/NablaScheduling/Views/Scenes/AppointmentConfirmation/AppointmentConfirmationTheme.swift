import NablaCore
import UIKit

public extension NablaTheme {
    enum AppointmentConfirmationTheme {
        /// Background color for the appointment confirmation view.
        public static var backgroundColor = Colors.Background.underCard
        /// Background color for the appointment confirmation header view.
        public static var headerBackgroundColor = Colors.Fill.card
        /// Background color for the appointment confirmation header view.
        public static var headerCornerRadius = CGFloat(12)
        
        /// Color used to display the name of the doctor.
        public static var doctorNameColor = Colors.Text.base
        /// Font used to display the name of the doctor.
        public static var doctorNameFont = Fonts.subtitleBold
        /// Color used to display details of the doctor.
        public static var doctorDescriptionColor = Colors.Text.subdued
        /// Font used to display details of the doctor.
        public static var doctorDescriptionFont = Fonts.body
        
        /// Color used to display legal disclaimers of the appointment.
        public static var disclaimersTextColor = Colors.Text.base
        /// Font used to display legal disclaimers of the appointment.
        public static var disclaimersFont = Fonts.body
        /// Color used for displaying the error when an error loading the disclaimers occured.
        public static var disclaimersErrorTextColor = Colors.Text.base
        /// Font used for displaying the error when an error loading the disclaimers occured.
        public static var disclaimersErrorFont = Fonts.body
        /// Style of the retry button when an error loading the disclaimers occured.
        public static var disclaimersErrorRetryButton = Button.accent
        
        /// Color used for the text of the cell to display appointment time.
        public static var captionTextColor: UIColor = .nabla.dynamic(lightMode: Colors.Text.accent, darkMode: Colors.Text.onAccent)
        /// Color used for background of the cell to display appointment time.
        public static var captionBackgroundColor: UIColor = .nabla.dynamic(lightMode: Colors.Fill.accentSubdued, darkMode: Colors.Fill.accent)
        /// Color used for the border of the capsule to display appointment time.
        public static var captionBorderColor: UIColor = Colors.Stroke.accent
        /// Shape used for the border of the capsule to display appointment time.
        public static var captionShape: CaptionShape = .capsule
        /// Font used for the text of the capsule to display appointment time.
        public static var captionFont = Fonts.bodyMedium
        
        /// Style of the checkbox for legal disclaimers.
        public static var checkbox = Checkbox.base
        /// Style of the button to confirm the appointment.
        public static var confirmButton = Button.accent
        
        public enum CaptionShape {
            case capsule
            case rounderRect(cornerRadius: CGFloat)
        }
    }
}
