import Foundation
import UIKit

protocol MessageContentView: UIView {
    associatedtype ContentViewModel
    
    func configure(with viewModel: ContentViewModel, sender: ConversationMessageSender)
    func prepareForReuse()
}
