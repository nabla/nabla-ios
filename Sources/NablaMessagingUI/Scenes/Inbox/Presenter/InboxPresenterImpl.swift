import Foundation
import NablaCore
import NablaMessagingCore

public protocol InboxDelegate: AnyObject {
    func inbox(didCreate conversation: Conversation)
    func inbox(didSelect conversation: Conversation)
}

class InboxPresenterImpl: InboxPresenter {
    // MARK: - Initializer

    init(
        logger: Logger,
        viewContract: InboxViewContract,
        delegate: InboxDelegate,
        client: NablaMessagingClientProtocol
    ) {
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

    private func createConversation() {
        let conversation = client.startConversation()
        delegate?.inbox(didCreate: conversation)
    }
}
