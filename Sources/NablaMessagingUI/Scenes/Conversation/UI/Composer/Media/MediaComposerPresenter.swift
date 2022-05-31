import Foundation
import NablaMessagingCore

protocol MediaComposerPresenterDelegate: AnyObject {
    func mediaComposerPresenter(_ presenter: MediaComposerPresenter, didUpdateMedias medias: [Media])
}

protocol MediaComposerPresenter: Presenter {
    func add(_ medias: [Media])
    func emptyMedias()
    func didTapDeleteButtonForMedia(at index: Int)
}
