import Foundation

open class RefetchTrigger {
    // MARK: - Public
    
    open var identifier: String {
        UUID().uuidString
    }
    
    public func trigger() {
        NotificationCenter.default.post(name: Self.refetchWatchersNotifiationName, object: nil, userInfo: nil)
    }
    
    // MARK: - Internal
    
    static let refetchWatchersNotifiationName = Notification.Name(rawValue: "com.nabla.refetchWatchersNotifiation")
}
