import Foundation

public final class PatientNameComponentsFormatter {
    public enum Style {
        case fullName
        case initials
    }

    public init(style: Style) {
        self.style = style
    }

    public func string(from components: PatientNameComponents) -> String {
        switch style {
        case .initials:
            guard let firstLetter = components.displayName.first else { return "" }
            return String(firstLetter).capitalized
        case .fullName:
            return components.displayName
        }
    }

    private let style: Style
}
