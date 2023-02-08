import Foundation
import NablaCore
import NablaMessagingCore

enum ConversationViewState {
    case loading
    case loaded(items: [ConversationViewItem], showComposer: Bool, isRefreshing: Bool)
    case error(viewModel: ErrorViewModel)
}

protocol ConversationViewItem {
    var id: UUID { get }
    
    var hashValue: Int { get } // swiftlint:disable:this legacy_hashing
    func hash(into hasher: inout Hasher)
}

struct ConversationViewModel {
    let title: String?
    let subtitle: String?
    let avatar: AvatarViewModel
}

protocol ConversationViewContract: AnyObject {
    var showRecordAudioMessageButton: Bool { get set }
    
    func configure(withConversation: ConversationViewModel)
    func configure(withState state: ConversationViewState)
    func emptyComposer()
    func displayMediaPicker(source: ImagePickerSource)
    func displayDocumentScanner()
    @available(iOS 14, *) func displayDocumentPicker()
    func displayImageDetail(for media: ImageFile)
    func displayDocumentDetail(for media: DocumentFile)
    func displayVideoCallRoom(url: String, token: String)
    func showErrorAlert(viewModel: AlertViewModel)
    func set(replyToMessage: ConversationViewMessageItem)
    func scrollToItem(withId id: UUID)
}

protocol ConversationViewMessageItem: ConversationViewItem {
    var sender: NablaMessagingCore.ConversationMessageSender { get }
    var sendingState: ConversationMessageSendingState { get }
    var replyTo: ConversationViewMessageItem? { get }
    var date: Date { get }
    var isContiguous: Bool { get set }
    var isFocused: Bool { get set }
}
