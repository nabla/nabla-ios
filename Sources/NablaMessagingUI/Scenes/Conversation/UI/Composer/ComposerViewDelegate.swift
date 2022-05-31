import Foundation
import NablaMessagingCore

protocol ComposerViewDelegate: AnyObject {
    func composerViewDidTapOnSend(_ composerView: ComposerView)
    func composerView(_ composerView: ComposerView, didFinishRecordingAudioFile file: AudioFile)
    func composerViewDidUpdateTextDraft(_ composerView: ComposerView)
    func composerViewDidTapOnAddMedia(_ composerView: ComposerView)
}
