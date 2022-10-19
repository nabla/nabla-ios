import Foundation
import NablaMessagingCore

// sourcery: AutoMockable
protocol ConversationPresenter: Presenter {
    func didTapOnSend(text: String, medias: [Media], replyingToMessageUUID replyToUUID: UUID?)
    func didUpdateDraftText(_ text: String)
    func didFinishRecordingAudioFile(_ file: AudioFile, replyingToMessageUUID replyToUUID: UUID?)
    func didTapDeleteMessageButton(withId messageId: UUID)
    func didTap(image: ImageFile)
    func didTap(document: DocumentFile)
    func didTapTextItem(withId: UUID)
    func didReplyToMessage(withId: UUID)
    func didTapMessagePreview(withId: UUID)
    func didTapCameraButton()
    func didTapPhotoLibraryButton()
    func didTapJoinVideoCall(url: String, token: String)
    func didTapScanDocumentButton()
    @available(iOS 14, *) func didTapDocumentLibraryButton()
    func didReachEndOfConversation()
    func retry()
}
