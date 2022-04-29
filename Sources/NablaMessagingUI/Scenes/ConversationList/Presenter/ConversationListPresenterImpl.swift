import Foundation
import NablaMessagingCore
import NablaUtils

final class ConversationListPresenterImpl: ConversationListPresenter {
    // MARK: - Public
    
    private weak var delegate: ConversationListDelegate?
    
    init(viewContract: ConversationListViewContract,
         delegate: ConversationListDelegate,
         client: NablaClient) {
        self.viewContract = viewContract
        self.delegate = delegate
        self.client = client
    }
    
    // MARK: - ConversationListPresenter
    
    func start() {
        isLoading = true
        watcher = client.watchConversationList(callback: { [weak self] result in
            self?.isLoading = false
            self?.handle(result: result)
        })
    }
    
    func didSelectConversation(at indexPath: IndexPath) {
        delegate?.conversationList(didSelect: list.conversations[indexPath.row])
    }
    
    func didScrollToBottom() {
        guard list.hasMore, !isLoading else { return }
        isLoading = true
        loadMoreAction = watcher?.loadMore { [weak self] _ in
            self?.isLoading = false
        }
    }
    
    func didTapRetry() {
        guard !isLoading else { return }
        isLoading = true
        loadMoreAction = watcher?.loadMore { [weak self] _ in
            self?.isLoading = false
        }
    }
    
    // MARK: - Private
    
    private let client: NablaClient
    private weak var viewContract: ConversationListViewContract?
    
    private var list: ConversationList = .empty {
        didSet {
            displayContent()
        }
    }
    
    private var isLoading = false {
        didSet {
            if isLoading {
                displayLoading()
            } else {
                hideLoading()
            }
        }
    }
    
    private var watcher: PaginatedWatcher?
    private var loadMoreAction: Cancellable?
    
    private func handle(result: Result<ConversationList, Error>) {
        switch result {
        case let .success(list):
            self.list = list
        case let .failure(error):
            let viewModel = ErrorViewModel(message: error.localizedDescription, buttonTitle: L10n.conversationListButtonRetry)
            viewContract?.configure(with: .error(viewModel))
        }
    }
    
    private func displayContent() {
        let viewModel = ConversationListViewModelMapper().map(conversations: list.conversations)
        viewContract?.configure(with: .loaded(viewModel: viewModel))
    }
    
    private func displayLoading() {
        if list.conversations.isEmpty {
            viewContract?.configure(with: .loading)
        } else {
            viewContract?.displayLoadingMore()
        }
    }
    
    private func hideLoading() {
        viewContract?.hideLoadingMore()
    }
}
