import Foundation

public final class ProviderNameComponentsFormatter {
    public enum Style {
        case fullNameWithPrefix
        case abbreviatedNameWithPrefix
        case initials
    }

    public init(style: Style) {
        self.style = style
    }

    public func string(from components: ProviderNameComponents) -> String {
        switch style {
        case .initials:
            return String([components.firstName, components.lastName].compactMap(\.?.first))
        case .abbreviatedNameWithPrefix:
            if components.prefix != nil {
                return [components.prefix, components.lastName].compactMap(identity).joined(separator: " ")
            } else {
                fallthrough
            }
        case .fullNameWithPrefix:
            var personNameComponents = PersonNameComponents()
            personNameComponents.namePrefix = components.prefix
            personNameComponents.givenName = components.firstName
            personNameComponents.familyName = components.lastName
            let formatter = PersonNameComponentsFormatter()
            formatter.style = .long
            return formatter.string(from: personNameComponents)
        }
    }

    private let style: Style
}
