import Foundation
import NablaMessagingCore

final class ConversationListPresenterImpl: ConversationListPresenter {
    // MARK: - Public
    
    private weak var delegate: ConversationListDelegate?
    
    init(
        logger: Logger,
        viewContract: ConversationListViewContract,
        delegate: ConversationListDelegate,
        client: NablaMessagingClient
    ) {
        self.logger = logger
        self.viewContract = viewContract
        self.delegate = delegate
        self.client = client
    }
    
    // MARK: - ConversationListPresenter
    
    func start() {
        watchConversations()
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
        watchConversations()
    }
    
    // MARK: - Private

    private let logger: Logger
    private let client: NablaMessagingClient
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
    
    private func watchConversations() {
        guard !isLoading else { return }
        isLoading = true
        watcher = client.watchConversations(handler: { [weak self] result in
            self?.isLoading = false
            self?.handle(result: result)
        })
    }
    
    private func handle(result: Result<ConversationList, NablaError>) {
        switch result {
        case let .success(list):
            self.list = list
        case let .failure(error):
            logger.error(message: "Failed to watch conversations with error: \(error.localizedDescription)")
            let viewModel = ErrorViewModel(
                message: L10n.conversationListLoadErrorLabel,
                buttonTitle: L10n.conversationListButtonRetry
            )
            configureView(with: .error(viewModel))
        }
    }

    private func displayContent() {
        let viewModel = ConversationListViewModelMapper().map(conversations: list.conversations)
        configureView(with: .loaded(viewModel: viewModel))
    }

    private func displayLoading() {
        if list.conversations.isEmpty {
            configureView(with: .loading)
        } else {
            displayLoadingMore()
        }
    }

    private func displayLoadingMore() -> Void? {
        DispatchQueue.main.async {
            self.viewContract?.displayLoadingMore()
        }
    }

    private func hideLoading() {
        DispatchQueue.main.async {
            self.viewContract?.hideLoadingMore()
        }
    }

    private func configureView(with state: ConversationListViewState) {
        DispatchQueue.main.async {
            self.viewContract?.configure(with: state)
        }
    }
}
