import Foundation
import UIKit

protocol MessageContentView: UIView {
    associatedtype ContentViewModel
    
    func configure(with viewModel: ContentViewModel)
    func configure(sender: ConversationMessageSender)
    func prepareForReuse()
}
