import Foundation

public class NotificationRefetchTrigger: RefetchTrigger {
    // MARK: - Private
    
    public init(name: Notification.Name) {
        self.name = name
    }
    
    // MARK: - Private
    
    private let name: Notification.Name
    
    private func observeEnterForeground() {
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
