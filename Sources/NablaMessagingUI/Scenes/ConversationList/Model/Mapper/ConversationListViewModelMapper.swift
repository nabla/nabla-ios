import Foundation
import NablaMessagingCore

struct ConversationListViewModelMapper {
    // MARK: - Public
    
    func map(conversations: [Conversation]) -> ConversationListViewModel {
        let items = conversations.map { conversation in
            ConversationListItemViewModel(
                avatar: AvatarViewModel(url: conversation.avatarURL, text: nil),
                title: conversation.title ?? L10n.conversationListEmptyPreview,
                lastMessage: conversation.lastMessagePreview,
                lastUpdatedTime: lastUpdatedTime(from: conversation),
                isUnread: conversation.isUnread
            )
        }
        
        return ConversationListViewModel(items: items)
    }
    
    // MARK: - Private
    
    private var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter(locale: .server)
        formatter.setLocalizedDateFormatFromTemplate("E")
        return formatter
    }()
    
    private var dateInYearFormatter: DateFormatter = {
        let formatter = DateFormatter(locale: .server)
        formatter.setLocalizedDateFormatFromTemplate("MM/dd")
        return formatter
    }()
    
    private var dateLongAgoFormatter: DateFormatter = {
        let formatter = DateFormatter(locale: .server)
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter(locale: .server)
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    private func lastUpdatedTime(from conversation: Conversation) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(conversation.lastUpdatedTime) {
            return timeFormatter.string(from: conversation.lastUpdatedTime)
        } else if calendar.isDateInYesterday(conversation.lastUpdatedTime) {
            return L10n.conversationListLastMessageYesterday
        } else if calendar.isDateInWeek(conversation.lastUpdatedTime) {
            return shortDateFormatter.string(from: conversation.lastUpdatedTime)
        } else if calendar.isDateInYear(conversation.lastUpdatedTime) {
            return dateInYearFormatter.string(from: conversation.lastUpdatedTime)
        } else {
            return dateLongAgoFormatter.string(from: conversation.lastUpdatedTime)
        }
    }
}

private extension Calendar {
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
}
