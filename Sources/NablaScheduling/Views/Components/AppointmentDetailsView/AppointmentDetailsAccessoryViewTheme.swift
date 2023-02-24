import NablaCore
import UIKit

public extension AppointmentDetailsAccessoryView {
    struct Theme {
        /// Color used to draw the icon.
        var imageColor: UIColor
        
        /// Color used for the first text in the view.
        var titleColor: UIColor
        /// Font used for the first text in the view.
        var titleFont: UIFont
        
        /// Color used for the second text in the view.
        var subtitleColor: UIColor
        /// Font used for the second text in the view.
        var subtitleFont: UIFont
        
        /// Color used for the third text in the view.
        var extraColor: UIColor
        /// Font used for the third text in the view.
        var extraFont: UIFont
    }
}
