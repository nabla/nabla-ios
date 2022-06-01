import Foundation
import NablaMessagingCore

class MediaComposerPresenterImplementation: MediaComposerPresenter {
    init(viewContract: MediaComposerViewContract, delegate: MediaComposerPresenterDelegate) {
        self.viewContract = viewContract
        self.delegate = delegate
    }

    // MARK: - Presenter

    func start() {
        reloadData()
    }

    // MARK: MediaComposerPresenter

    func didTapDeleteButtonForMedia(at index: Int) {
        medias.remove(at: index)
    }

    func add(_ medias: [Media]) {
        self.medias.append(contentsOf: medias)
    }

    func emptyMedias() {
        medias = []
    }

    // MARK: - Private

    private weak var delegate: MediaComposerPresenterDelegate?
    private weak var viewContract: MediaComposerViewContract?

    private var medias: [Media] = [] {
        didSet {
            delegate?.mediaComposerPresenter(self, didUpdateMedias: medias)
            reloadData()
        }
    }

    private func reloadData() {
        let transformer = MediaComposerItemViewModelTransformer()
        let viewModels = transformer.transform(medias: medias)
        viewContract?.configure(with: viewModels)
    }
}
