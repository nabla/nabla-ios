import Foundation

public class RefetchTrigger {
    // MARK: - Internal
    
    static var refetchWatchersNotifiationName = Notification.Name(rawValue: "com.nabla.refetchWatchersNotifiation")
    
    func trigger() {
        NotificationCenter.default.post(name: Self.refetchWatchersNotifiationName, object: nil, userInfo: nil)
    }
}
