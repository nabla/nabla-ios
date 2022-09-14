import Foundation

extension Provider {
    func formatName(style: PersonNameComponentsFormatter.Style) -> String {
        var components = PersonNameComponents()
        components.namePrefix = prefix
        components.givenName = firstName
        components.familyName = lastName
        let formatter = PersonNameComponentsFormatter()
        formatter.style = style
        return formatter.string(from: components)
    }
}
