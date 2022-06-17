import Foundation

protocol InboxViewContract: AnyObject {
    func set(loading: Bool)
    func display(error: String)
}
