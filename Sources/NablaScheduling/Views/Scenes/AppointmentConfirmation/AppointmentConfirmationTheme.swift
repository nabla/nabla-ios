import NablaCore
import UIKit

public extension NablaTheme {
    enum AppointmentConfirmationTheme {
        /// Background color for the appointment confirmation view.
        public static var backgroundColor = Colors.Background.underCard
        
        /// Theme for the details card at the top of the screen.
        public static var header: AppointmentDetailsView.Theme = AppointmentDetailsViewTheme.base
        
        /// Color used to display legal disclaimers of the appointment.
        public static var disclaimersTextColor = Colors.Text.base
        /// Font used to display legal disclaimers of the appointment.
        public static var disclaimersFont = Fonts.body
        /// Color used for displaying the error when an error loading the disclaimers occurred.
        public static var disclaimersErrorTextColor = Colors.Text.base
        /// Font used for displaying the error when an error loading the disclaimers occurred.
        public static var disclaimersErrorFont = Fonts.body
        /// Style of the retry button when an error loading the disclaimers occurred.
        public static var disclaimersErrorRetryButton = Button.accent
        
        /// Style of the checkbox for legal disclaimers.
        public static var checkbox = Checkbox.base
        /// Style of the button to confirm the appointment.
        public static var confirmButton = Button.accent
    }
}
