import UIKit

public extension AppointmentDetailsView.CaptionView {
    struct Theme {
        public enum Shape {
            case capsule
            case rounderRect(cornerRadius: CGFloat)
        }
        
        /// Color used for the text of the cell to display appointment time.
        public var textColor: UIColor
        /// Color used for background of the cell to display appointment time.
        public var backgroundColor: UIColor
        /// Color used for the border of the capsule to display appointment time.
        public var borderColor: UIColor
        /// Shape used for the border of the capsule to display appointment time.
        public var shape: Shape
        /// Font used for the text of the capsule to display appointment time.
        public var font: UIFont
    }
}
