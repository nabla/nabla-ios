import Foundation
import UIKit

protocol MessageContentView: UIView {
    associatedtype ContentViewModel
    
    func configure(with viewModel: ContentViewModel) throws
    func configure(sender: ConversationMessageSender)
    func prepareForReuse()
}
