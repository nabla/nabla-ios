import Foundation

enum HTTPHeaders {
    static let Accept = "Accept"
    static let Authorization = "Authorization"
    static let NablaAuthorization = "X-Nabla-Authorization"
    static let ContentType = "Content-Type"
    static let NablaApiKey = "X-Nabla-API-Key"
    
    static var extra = [String: String]() {
        didSet { notificationCenter.post(name: Notification.extraHeadersChanged.name, object: nil) }
    }
    
    static func addObserver(_ observer: Any, selector: Selector, notification: Notification) {
        notificationCenter.addObserver(observer, selector: selector, name: notification.name, object: nil)
    }
    
    static func removeObserver(_ observer: Any) {
        notificationCenter.removeObserver(observer)
    }
    
    private static let notificationCenter = NotificationCenter()
    
    enum Notification {
        case extraHeadersChanged
        
        fileprivate var name: Foundation.Notification.Name {
            .init(rawValue: String(reflecting: self))
        }
    }
}
