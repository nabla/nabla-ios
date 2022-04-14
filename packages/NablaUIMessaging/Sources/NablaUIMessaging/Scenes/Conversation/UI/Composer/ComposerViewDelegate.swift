import Foundation

protocol ComposerViewDelegate: AnyObject {
    func composerViewDidTapOnSend(_ composerView: ComposerView)
    func composerViewDidTapOnAddMedia(_ composerView: ComposerView)
}
