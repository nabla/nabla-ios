import Foundation

struct ConversationListViewModel {
    let items: [ConversationListItemViewModel]
    let isRefreshing: Bool
}

extension ConversationListViewModel {
    static var empty: ConversationListViewModel {
        ConversationListViewModel(items: [], isRefreshing: false)
    }
}
