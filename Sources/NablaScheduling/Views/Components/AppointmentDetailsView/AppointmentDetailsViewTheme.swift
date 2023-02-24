import UIKit

public extension AppointmentDetailsView {
    struct Theme {
        /// Background color for the view.
        public var backgroundColor: UIColor
        /// Background color for the view.
        public var cornerRadius: CGFloat
        
        /// Color used to display the name of the doctor.
        public var doctorNameColor: UIColor
        /// Font used to display the name of the doctor.
        public var doctorNameFont: UIFont
        /// Color used to display details of the doctor.
        public var doctorDescriptionColor: UIColor
        /// Font used to display details of the doctor.
        public var doctorDescriptionFont: UIFont
        
        /// Color used to display the separator between the doctor and the appointment details.
        public var separatorColor: UIColor
        
        /// Theme used for each element of the appointment details
        public var accessoriesTheme: AppointmentDetailsAccessoryView.Theme
    }
}
