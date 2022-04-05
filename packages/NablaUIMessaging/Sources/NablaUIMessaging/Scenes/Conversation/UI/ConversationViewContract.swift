import Foundation

enum ConversationViewState {
    case loading
    case empty
    case loaded(items: [ConversationViewItem])
    case error
}
    
enum ConversationViewItem {
    case text
}

protocol ConversationViewContract: AnyObject {
    func configure(withState state: ConversationViewState)
}
