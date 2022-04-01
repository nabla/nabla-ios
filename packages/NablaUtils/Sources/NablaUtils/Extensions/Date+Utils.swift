import Foundation

public extension Date {
    var isPast: Bool {
        timeIntervalSinceNow < 0
    }

    var isFuture: Bool {
        !isPast
    }
    
    /// Formats a date as an ISO 8601 string.
    func toIsoString() -> String {
        iso8601DateFormatter.string(from: self)
    }
    
    /// Returns a date from a valid ISO 8601 string.
    static func from(isoString: String) -> Date? {
        iso8601DateFormatter.date(from: isoString)
    }
}

private let iso8601DateFormatter: ISO8601DateFormatter = {
    // swiftlint:disable:next no_default_dateformatter_initializer
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    // swiftlint:disable:next force_unwrapping
    formatter.timeZone = TimeZone(secondsFromGMT: 0)!
    return formatter
}()
