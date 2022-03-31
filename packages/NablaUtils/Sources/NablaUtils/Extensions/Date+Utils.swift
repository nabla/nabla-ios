import Foundation

public extension Date {
    var isPast: Bool {
        timeIntervalSinceNow < 0
    }

    var isFuture: Bool {
        !isPast
    }
}
