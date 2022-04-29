import Foundation

struct ConversationListViewModel {
    let items: [ConversationListItemViewModel]
}

extension ConversationListViewModel {
    static var empty: ConversationListViewModel {
        ConversationListViewModel(items: [])
    }
}
