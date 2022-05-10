import Foundation

public extension Calendar {
    func isDateInWeek(_ date: Date) -> Bool {
        let today = Date()
        guard let week = self.date(byAdding: .day, value: -7, to: today) else { return false }

        return compare(date, to: week, toGranularity: .day) == .orderedDescending
    }

    func isDateInYear(_ date: Date) -> Bool {
        let today = Date()
        guard let year = self.date(byAdding: .year, value: -1, to: today) else { return false }

        return compare(date, to: year, toGranularity: .year) == .orderedDescending
    }

    func areDatesMoreThanAnHourApart(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date1, to: date2)
        guard let hours = components.hour else { return false }

        return hours > 1
    }
}
