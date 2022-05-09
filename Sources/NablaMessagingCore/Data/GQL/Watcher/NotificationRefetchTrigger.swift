import Foundation

public class NotificationRefetchTrigger: RefetchTrigger {
    // MARK: - Private
    
    public init(name: Notification.Name) {
        super.init()
        observeNotification(name: name)
    }
    
    // MARK: - Private
    
    private func observeNotification(name: Notification.Name) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationHanlder),
            name: name,
            object: nil
        )
    }
    
    @objc private func notificationHanlder() {
        trigger()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
