import Foundation
import NablaMessagingCore

struct ConversationListViewModelMapper {
    // MARK: - Public
    
    func map(conversations: [Conversation]) -> ConversationListViewModel {
        let items = conversations.map { conversation in
            ConversationListItemViewModel(
                avatar: AvatarViewModel(url: conversation.providers.first?.provider.avatarURL, text: nil),
                title: conversation.inboxPreviewTitle,
                lastMessage: conversation.lastMessagePreview,
                lastUpdatedTime: lastUpdatedTime(from: conversation),
                isUnread: conversation.patientUnreadMessageCount > 0
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
        if calendar.isDateInToday(conversation.lastModified) {
            return timeFormatter.string(from: conversation.lastModified)
        } else if calendar.isDateInYesterday(conversation.lastModified) {
            return L10n.conversationListLastMessageYesterday
        } else if calendar.isDateInWeek(conversation.lastModified) {
            return shortDateFormatter.string(from: conversation.lastModified)
        } else if calendar.isDateInYear(conversation.lastModified) {
            return dateInYearFormatter.string(from: conversation.lastModified)
        } else {
            return dateLongAgoFormatter.string(from: conversation.lastModified)
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
