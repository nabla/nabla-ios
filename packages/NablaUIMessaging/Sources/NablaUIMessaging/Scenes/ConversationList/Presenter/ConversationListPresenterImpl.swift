import Foundation
import NablaCore
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
        watcher = client.watchConversationList(callback: handle)
        viewContract?.configure(with: ConversationListViewModelMapper().stubs())
    }

    func didSelectConversation(at _: IndexPath) {
        delegate?.conversationList(didSelectConversationWithId: UUID())
    }

    func didScrollToBottom() {
        guard !isLoading else { return }
        isLoading = true
        watcher?.loadMore { [weak self] _ in
            self?.isLoading = false
            // Do something if error
        }
    }

    // MARK: - Private

    private let client: NablaClient
    private weak var viewContract: ConversationListViewContract?

    private var watcher: PaginatedWatcher?
    private var isLoading = false

    private func handle(result _: Result<ConversationList, GQLError>) {
        // Display list or error
    }
}
