import Foundation
import NablaMessagingCore

enum ConversationViewState {
    case loading
    case empty
    case loaded(items: [ConversationViewItem])
    case error(viewModel: ErrorViewModel)
}

protocol ConversationViewItem {
    var id: UUID { get }
    
    var hashValue: Int { get } // swiftlint:disable:this legacy_hashing
    func hash(into hasher: inout Hasher)
}

struct ConversationViewModel {
    let title: String?
    let avatar: AvatarViewModel
}

protocol ConversationViewContract: AnyObject {
    var showRecordAudioMessageButton: Bool { get set }
    
    func configure(withConversation: ConversationViewModel)
    func configure(withState state: ConversationViewState)
    func emptyComposer()
    func displayMediaPicker(source: ImagePickerSource)
    @available(iOS 14, *) func displayDocumentPicker()
    func displayImageDetail(for media: Media)
    func displayDocumentDetail(for media: Media)
    func showErrorAlert(viewModel: AlertViewModel)
}

protocol ConversationViewMessageItem: ConversationViewItem {
    var sender: NablaMessagingCore.ConversationMessageSender { get }
    var sendingState: ConversationMessageSendingState { get }
    var date: Date { get }
    var isContiguous: Bool { get set }
    var isFocused: Bool { get set }
}
