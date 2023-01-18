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
            caption: .init(
                textColor: .nabla.dynamic(lightMode: Colors.Text.accent, darkMode: Colors.Text.onAccent),
                backgroundColor: .nabla.dynamic(lightMode: Colors.Fill.accentSubdued, darkMode: Colors.Fill.accent),
                borderColor: Colors.Stroke.accent,
                shape: .capsule,
                font: Fonts.bodyMedium
            ),
            addressColor: Colors.Text.subdued,
            addressFont: Fonts.bodyMedium,
            addressExtraColor: Colors.Text.subdued,
            addressExtraFont: Fonts.smallText
        )
    }
}
