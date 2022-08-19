import Foundation
import NablaMessagingCore
import UIKit

protocol ComposerViewDelegate: AnyObject {
    func composerViewDidTapOnSend(_ composerView: ComposerView)
    func composerView(_ composerView: ComposerView, didFinishRecordingAudioFile file: AudioFile)
    func composerViewDidUpdateTextDraft(_ composerView: ComposerView)
    func composerView(_ composerView: ComposerView, didTapOnAddMediaFrom sender: UIView)
}
