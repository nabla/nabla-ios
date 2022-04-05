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
        viewContract?.configure(with: ConversationListViewModelMapper().stubs())
    }

    func didSelectConversation(at _: IndexPath) {
        delegate?.conversationList(didSelectConversationWithId: UUID())
    }

    // MARK: - Private

    private let client: NablaClient
    private weak var viewContract: ConversationListViewContract?
}
