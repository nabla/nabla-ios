import NablaCore
import UIKit

public extension NablaTheme {
    enum AppointmentDetailsViewTheme {
        public static var base = AppointmentDetailsView.Theme(
            backgroundColor: Colors.Fill.card,
            cornerRadius: 12,
            doctorNameColor: Colors.Text.base,
            doctorNameFont: Fonts.subtitleBold,
            doctorDescriptionColor: Colors.Text.subdued,
            doctorDescriptionFont: Fonts.body,
            separatorColor: Colors.Stroke.subdued,
            accessoriesTheme: AppointmentDetailsAccessoryViewTheme.base
        )
    }
    
    enum AppointmentDetailsAccessoryViewTheme {
        public static var base = AppointmentDetailsAccessoryView.Theme(
            imageColor: Colors.Text.accent,
            titleColor: Colors.Text.accent,
            titleFont: Fonts.bodyMedium,
            subtitleColor: Colors.Text.subdued,
            subtitleFont: Fonts.smallMedium,
            extraColor: Colors.Text.subdued,
            extraFont: Fonts.smallText
        )
    }
}
