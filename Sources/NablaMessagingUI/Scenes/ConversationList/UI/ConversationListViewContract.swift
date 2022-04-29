import Foundation

enum ConversationListViewState {
    case loaded(viewModel: ConversationListViewModel)
    case error(ErrorViewModel)
    case loading
}

protocol ConversationListViewContract: AnyObject {
    func configure(with state: ConversationListViewState)
    func displayLoadingMore()
    func hideLoadingMore()
}
