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
        
        /// Theme for the caption subview.
        public var caption: CaptionView.Theme
        
        /// Color used to display the address.
        public var addressColor: UIColor
        /// Font used to display the address.
        public var addressFont: UIFont
        /// Color used to display the address extra information.
        public var addressExtraColor: UIColor
        /// Font used to display the address extra information.
        public var addressExtraFont: UIFont
    }
}
