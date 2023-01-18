import NablaCore
import UIKit

public extension NablaTheme {
    enum AppointmentDetailsTheme {
        /// Background color for the appointment confirmation view.
        public static var backgroundColor = Colors.Background.underCard
        
        /// Theme for the details card at the top of the screen.
        public static var header: AppointmentDetailsView.Theme = AppointmentDetailsViewTheme.base
        
        /// Style of the button to cancel the appointment.
        public static var cancelButton = Button.danger
    }
}
