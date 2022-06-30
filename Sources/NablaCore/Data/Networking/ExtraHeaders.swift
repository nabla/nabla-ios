import Foundation

public protocol ExtraHeaders {
    var all: [String: String] { get }
    func set(_ value: CustomStringConvertible?, for key: String)
    func addObserver(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
}

final class ExtraHeadersImpl: ExtraHeaders {
    // MARK: - Internal
    
    public var all: [String: String] {
        headers
    }
    
    public func set(_ value: CustomStringConvertible?, for key: String) {
        headers[key] = value?.description
        notificationCenter.post(name: Notifications.headersDidChange, object: nil)
    }
    
    public func addObserver(_ observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: Notifications.headersDidChange, object: nil)
    }
    
    public func removeObserver(_ observer: Any) {
        notificationCenter.removeObserver(observer)
    }
    
    // MARK: Initializer
    
    init(_ headers: [String: String]) {
        self.headers = headers
    }
    
    // MARK: - Private
    
    private enum Notifications {
        static let headersDidChange = Notification.Name(rawValue: "ExtraHeaders.headersDidChange")
    }
    
    private let notificationCenter = NotificationCenter()
    
    private var headers = [String: String]()
}
