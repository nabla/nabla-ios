import NablaCore
import UIKit

public extension NablaTheme {
    struct AppointmentListViewTheme {
        /// Color used for the background of the appointment list view.
        public static var backgroundColor = Colors.Background.underCard
        
        /// Color used for the text of the empty state where no appointments are scheduled.
        public static var emptyViewTextColor: UIColor = Colors.Text.subdued
        /// Font used for the text of the empty state where no appointments are scheduled.
        public static var emptyViewFont: UIFont = Fonts.subtitleMedium
        
        /// Style of the button used to schedule a new appointment.
        public static var button = Button.accent
        
        public enum CellTheme {
            /// Corner radius used for the background of an appointment cell.
            public static var cornerRadius = CGFloat(14)
            /// Color used for the background of an appointment cell.
            public static var backgroundColor = Colors.Fill.card
            /// Color used for the name of the doctor of an scheduled appointment.
            public static var titleColor = Colors.Text.base
            /// Color used for the name of the doctor of a past appointment.
            public static var titleDisabledColor = Colors.Text.subdued
            /// Font used for the name of the doctor of an appointment.
            public static var titleFont = Fonts.subtitleBold
            /// Color used for the time of an scheduled appointment.
            public static var subtitleColor = Colors.Text.subdued
            /// Color used for the time of a past appointment.
            public static var subtitleDisabledColor = Colors.Text.subdued
            /// Font used for the time of an appointment.
            public static var subtitleFont = Fonts.body
            /// Color of the button to edit an scheduled appointment.
            public static var moreButtonColor = Colors.Text.subdued
            
            /// Style of the button to join an appointment via video call.
            public static var button = Button.accentSubdued
        }
        
        private init() {}
    }
}
