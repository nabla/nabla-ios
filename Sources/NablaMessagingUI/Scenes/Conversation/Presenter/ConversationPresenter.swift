import Foundation
import NablaMessagingCore

// sourcery: AutoMockable
protocol ConversationPresenter: Presenter {
    func didTapOnSend(text: String, medias: [Media], replyingToMessageUUID replyToUUID: UUID?)
    func didUpdateDraftText(_ text: String)
    func didFinishRecordingAudioFile(_ file: AudioFile, replyingToMessageUUID replyToUUID: UUID?)
    func didTapDeleteMessageButton(withId messageId: UUID)
    func didTapMedia(_ media: Media)
    func didTapTextItem(withId: UUID)
    func didReplyToMessage(withId: UUID)
    func didTapMessagePreview(withId: UUID)
    func didTapCameraButton()
    func didTapPhotoLibraryButton()
    @available(iOS 14, *) func didTapDocumentLibraryButton()
    func didReachEndOfConversation()
    func retry()
}
