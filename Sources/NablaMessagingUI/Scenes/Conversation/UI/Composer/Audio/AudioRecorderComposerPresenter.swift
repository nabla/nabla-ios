import Foundation
import NablaMessagingCore

protocol AudioRecorderComposerPresenterDelegate: AnyObject {
    func audioRecorderComposerPresenterDidStartRecording(_ presenter: AudioRecorderComposerPresenter)
    func audioRecorderComposerPresenter(_ presenter: AudioRecorderComposerPresenter, didStopRecordingWithFile file: AudioFile)
    func audioRecorderComposerPresenterDidCancelRecording(_ presenter: AudioRecorderComposerPresenter)
    func audioRecorderComposerPresenterCanNotStartRecording(_ presenter: AudioRecorderComposerPresenter)
}

// sourcery: AutoMockable
protocol AudioRecorderComposerPresenter: Presenter {
    func userDidRequestStartRecording()
    func userDidRequestStopRecording()
    func userDidRequestCancelRecording()
}
