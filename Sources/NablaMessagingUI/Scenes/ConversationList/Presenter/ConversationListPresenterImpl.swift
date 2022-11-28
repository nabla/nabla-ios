import Combine
import Foundation
import NablaCore
import NablaMessagingCore

final class ConversationListPresenterImpl: ConversationListPresenter {
    // MARK: - Public
    
    private weak var delegate: ConversationListDelegate?
    
    init(
        logger: Logger,
        viewContract: ConversationListViewContract,
        delegate: ConversationListDelegate,
        client: NablaMessagingClientProtocol
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
        delegate?.conversationList(didSelect: list.elements[indexPath.row])
    }
    
    func didScrollToBottom() {
        guard let loadMore = list.loadMore, !isLoading else { return }
        isLoading = true
        Task(priority: .userInitiated) {
            try await loadMore()
            self.isLoading = false
        }
    }
    
    func didTapRetry() {
        watchConversations()
    }
    
    // MARK: - Private

    private let logger: Logger
    private let client: NablaMessagingClientProtocol
    private weak var viewContract: ConversationListViewContract?
    
    private var list: PaginatedList<Conversation> = .empty
    
    private var isLoading = false {
        didSet {
            if isLoading {
                displayLoading()
            } else {
                hideLoading()
            }
        }
    }
    
    private var watcher: AnyCancellable?
    
    private func watchConversations() {
        guard !isLoading else { return }
        isLoading = true
        watcher = client.watchConversations().nabla.drive(
            receiveValue: { [weak self] list in
                guard let self = self else { return }
                self.isLoading = false
                self.list = list
                let viewModel = ConversationListViewModelTransformer().transform(conversations: list.elements)
                self.configureView(with: .loaded(viewModel: viewModel))
            },
            receiveError: { [weak self] error in
                guard let self = self else { return }
                self.isLoading = false
                self.logger.warning(message: "Failed to watch conversations", extra: ["reason": error])
                let viewModel = ErrorViewModel(
                    message: L10n.conversationListLoadErrorLabel,
                    buttonTitle: L10n.conversationListButtonRetry
                )
                self.configureView(with: .error(viewModel))
            }
        )
    }

    private func displayLoading() {
        if list.elements.isEmpty {
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
