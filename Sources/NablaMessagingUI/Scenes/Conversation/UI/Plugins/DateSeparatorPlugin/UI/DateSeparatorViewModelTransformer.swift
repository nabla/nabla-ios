import Foundation

struct DateSeparatorViewModelTransformer {
    // MARK: - Public

    func transform(item: DateSeparatorViewItem) -> ConversationTextSeparatorCellViewModel {
        .init(text: text(from: item.date))
    }

    // MARK: - Private

    private var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E")
        return formatter
    }()

    private var dateInYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E d MMM")
        return formatter
    }()

    private var dateLongAgoFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E d MMM y")
        return formatter
    }()

    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    private func text(from date: Date) -> String {
        let calendar = Calendar.current
        let dateString: String
        if calendar.isDateInToday(date) {
            dateString = L10n.conversationDateSeparatorDateToday
        } else if calendar.isDateInYesterday(date) {
            dateString = L10n.conversationDateSeparatorDateYesterday
        } else if calendar.isDateInWeek(date) {
            dateString = shortDateFormatter.string(from: date)
        } else if calendar.isDateInYear(date) {
            dateString = dateInYearFormatter.string(from: date)
        } else {
            dateString = dateLongAgoFormatter.string(from: date)
        }
        return L10n.conversationDateSeparatorDateTime(dateString, timeFormatter.string(from: date))
    }
}
