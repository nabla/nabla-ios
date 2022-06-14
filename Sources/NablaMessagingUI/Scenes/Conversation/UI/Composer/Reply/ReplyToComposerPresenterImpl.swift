import Foundation
import NablaMessagingCore

class ReplyToComposerPresenterImpl: ReplyToComposerPresenter {
    struct Dependencies {
        let logger: Logger
    }

    weak var delegate: ReplyToComposerPresenterDelegate?

    // MARK: - Initializer

    init(
        viewContract: ReplyToComposerViewContract,
        dependencies: Dependencies
    ) {
        self.viewContract = viewContract
        logger = dependencies.logger
    }

    // MARK: - Presenter

    func start() {
        updateUI()
    }

    // MARK: - ReplyToComposerPresenter

    func didUpdate(message: ConversationViewMessageItem?) {
        self.message = message
    }

    func didTapCloseButton() {
        delegate?.replyToComposerPresenterDidTapCloseButton(self)
    }

    // MARK: - Private

    private let logger: Logger

    private weak var viewContract: ReplyToComposerViewContract?

    private var message: ConversationViewMessageItem? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        guard let message = message else { return }
        let viewModel = ReplyToComposerViewModelTransformer.transform(message: message)
        viewContract?.configure(with: viewModel)
    }
}
