import Foundation
import NablaCore

class Notifier<T> {
    // MARK: - Internal
    
    func observe(_ callback: @escaping (T) -> Void) -> Cancellable {
        Observer(
            notificationName: notificationName,
            center: center,
            callback: callback
        )
    }
    
    func notify(value: T) {
        center.post(name: notificationName, object: nil, userInfo: ["value": value])
    }
    
    // MARK: Init
    
    init(
        id: String,
        center: NotificationCenter = .default
    ) {
        notificationName = .init("Notififier.\(id)")
        self.center = center
    }
    
    // MARK: - Private
    
    private let notificationName: Notification.Name
    private let center: NotificationCenter
    
    private class Observer<T>: Cancellable {
        let notificationName: Notification.Name
        let center: NotificationCenter
        let callback: (T) -> Void
        
        func cancel() {
            center.removeObserver(self)
        }
        
        init(
            notificationName: Notification.Name,
            center: NotificationCenter,
            callback: @escaping (T) -> Void
        ) {
            self.notificationName = notificationName
            self.center = center
            self.callback = callback
            observe()
        }
        
        deinit {
            cancel()
        }
        
        private func observe() {
            center.addObserver(self, selector: #selector(notificationHandler(_:)), name: notificationName, object: nil)
        }
        
        @objc private func notificationHandler(_ notification: Notification) {
            guard let value = notification.userInfo?["value"] as? T else { return }
            callback(value)
        }
    }
}
