import Foundation

public extension Date {
    static var today: Date {
        Calendar.current.startOfDay(for: Date())
    }

    static var tomorrow: Date {
        today.adding(days: 1)
    }

    static var yesterday: Date {
        today.adding(days: -1)
    }

    func at(hour: Int, minute: Int, second: Int = 0) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = hour
        components.minute = minute
        components.second = second
        // swiftlint:disable:next force_unwrapping
        return Calendar.current.date(from: components)!
    }

    func adding(days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        // swiftlint:disable force_unwrapping
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.day! += days
        components.hour! += hours
        components.minute! += minutes
        components.second! += seconds
        return Calendar.current.date(from: components)!
        // swiftlint:enable force_unwrapping
    }
}
