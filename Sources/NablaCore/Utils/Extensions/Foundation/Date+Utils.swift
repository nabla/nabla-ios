import Foundation

extension Date: NablaExtendable {}

public extension NablaExtension where Base == Date {
    static func now() -> Date { Date() }
    
    var timeIntervalSinceNow: TimeInterval {
        base.timeIntervalSince(Self.now())
    }
    
    var isPast: Bool {
        timeIntervalSinceNow < 0
    }
    
    var isFuture: Bool {
        !isPast
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(base)
    }
    
    /// Formats a date as an ISO 8601 string.
    func toIsoString() -> String {
        iso8601DateFormatter.string(from: base)
    }
    
    /// Returns a date from a valid ISO 8601 string.
    static func from(isoString: String) -> Date? {
        iso8601DateFormatter.date(from: isoString)
    }
}

private let iso8601DateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    // swiftlint:disable:next force_unwrapping
    formatter.timeZone = TimeZone(secondsFromGMT: 0)!
    return formatter
}()
