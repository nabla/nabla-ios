import Foundation

protocol ComposerViewDelegate: AnyObject {
    func composerViewDidTapOnSend(_ composerView: ComposerView)
    func composerViewDidUpdateTextDraft(_ composerView: ComposerView)
    func composerViewDidTapOnAddMedia(_ composerView: ComposerView)
}
