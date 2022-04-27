import Foundation

public extension Optional where Wrapped == String {
    var isBlank: Bool {
        switch self {
        case .none:
            return true
        case let .some(value):
            return value.isEmpty
        }
    }
}
