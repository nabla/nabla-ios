import Foundation
import NablaCore
import NablaMessagingCore

public protocol InboxDelegate: AnyObject {
    func inbox(didCreate conversation: Conversation)
    func inbox(didSelect conversation: Conversation)
}

class InboxPresenterImpl: InboxPresenter {
    // MARK: - Initializer

    init(logger: Logger,
         viewContract: InboxViewContract,
         delegate: InboxDelegate,
         client: NablaMessagingClientProtocol) {
        self.logger = logger
        self.viewContract = viewContract
        self.delegate = delegate
        self.client = client
    }

    // MARK: - InboxPresenter

    func start() {}

    func userDidTapCreateConversation() {
        createConversation()
    }

    func userDidSelectConversation(_ conversation: Conversation) {
        delegate?.inbox(didSelect: conversation)
    }

    // MARK: - Private

    private let logger: Logger
    private let client: NablaMessagingClientProtocol

    private weak var viewContract: InboxViewContract?
    private weak var delegate: InboxDelegate?

    private var createConversationAction: Cancellable?

    private func createConversation() {
        guard createConversationAction == nil else { return }

        viewContract?.set(loading: true)
        createConversationAction = client.createConversation { [weak self] result in
            guard let self = self else { return }
            self.viewContract?.set(loading: false)
            self.createConversationAction = nil
            switch result {
            case let .failure(error):
                self.logger.warning(message: "Failed to create conversation", extra: ["reason": error])
                self.viewContract?.display(error: L10n.inboxErrorFailedToCreateConversationMessage(error.localizedDescription))
            case let .success(conversation):
                self.delegate?.inbox(didCreate: conversation)
            }
        }
    }
}
