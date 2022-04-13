import Foundation

protocol ConversationMessageCellContract: AnyObject {
    associatedtype ContentView: MessageContentView

    func configure(with viewModel: ConversationMessageViewModel<ContentView.ContentViewModel>)
}
