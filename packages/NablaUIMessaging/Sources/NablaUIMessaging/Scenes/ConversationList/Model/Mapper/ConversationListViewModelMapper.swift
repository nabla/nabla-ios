import Foundation

struct ConversationListViewModelMapper {
    func stubs() -> ConversationListViewModel {
        ConversationListViewModel(
            items: [
                ConversationListItemViewModel(
                    avatar: AvatarViewModel(url: "https://cataas.com/cat", text: nil),
                    title: "Burn",
                    lastMessage: "Lorem ipsum dolor sit amet et plus encore",
                    lastUpdatedTime: "15:59",
                    isUnread: true
                ),
                ConversationListItemViewModel(
                    avatar: AvatarViewModel(url: nil, text: "TT"),
                    title: "Irregular periods",
                    lastMessage: "Petit lorem ipsum",
                    lastUpdatedTime: "Mon.",
                    isUnread: false
                ),
            ]
        )
    }
}
