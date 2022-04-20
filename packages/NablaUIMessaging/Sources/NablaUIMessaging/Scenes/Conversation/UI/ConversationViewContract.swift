import Foundation

enum ConversationViewState {
    case loading
    case empty
    case loaded(items: [ConversationViewItem])
    case error(viewModel: ErrorViewModel)
}

protocol ConversationViewItemContent {
    var hashValue: Int { get } // swiftlint:disable:this legacy_hashing
    func hash(into hasher: inout Hasher)
}

struct ConversationViewItem: Hashable {
    let id: UUID = .init()
    let date: Date = .init()
    let content: ConversationViewItemContent

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        content.hash(into: &hasher)
    }

    static func == (lhs: ConversationViewItem, rhs: ConversationViewItem) -> Bool {
        lhs.id == rhs.id
            && lhs.date == rhs.date
            && lhs.content.hashValue == rhs.content.hashValue
    }
}

protocol ConversationViewContract: AnyObject {
    func configure(withState state: ConversationViewState)
    func emptyComposer()
}
