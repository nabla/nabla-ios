import Foundation

public class NotificationRefetchTrigger: RefetchTrigger {
    // MARK: - Public
    
    override public var identifier: String {
        "NotificationRefetchTrigger.\(name.rawValue)"
    }
    
    public init(name: Notification.Name) {
        self.name = name
        super.init()
        observeNotification(name: name)
    }
    
    // MARK: - Private
    
    private let name: Notification.Name
    
    private func observeNotification(name: Notification.Name) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationHandler),
            name: name,
            object: nil
        )
    }
    
    @objc private func notificationHandler() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.trigger()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
