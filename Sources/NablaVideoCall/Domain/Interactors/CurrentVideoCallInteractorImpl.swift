import Foundation
import NablaCore

struct CurrentVideoCallContext {
    let token: String
    let reopen: () -> Void
}

final class CurrentVideoCallInteractor {
    // MARK: - Internal
    
    var currentVideoCallToken: String? {
        currentVideoCallContext?.token
    }
    
    func watchCurrentVideoCall(callback: @escaping (_ token: String?) -> Void) -> Cancellable {
        CurrentVideoCallTokenWatcher(callback: callback, notificationCenter: notificationCenter)
    }
    
    func openCurrentVideoCall() {
        currentVideoCallContext?.reopen()
    }
    
    func becomeCurrentVideoCall(token: String, reopen: @escaping () -> Void) {
        currentVideoCallContext = CurrentVideoCallContext(token: token, reopen: reopen)
    }
    
    func resignCurrentVideoCall() {
        currentVideoCallContext = nil
    }
    
    // MARK: - Private
    
    private let notificationCenter: NotificationCenter = .init()
    
    private var currentVideoCallContext: CurrentVideoCallContext? {
        didSet { notifyChange() }
    }
    
    private func notifyChange() {
        notificationCenter.post(
            name: .currentVideoCallTokenDidChange,
            object: nil,
            userInfo: ["token": currentVideoCallToken as Any]
        )
    }
}

extension NSNotification.Name {
    static let currentVideoCallTokenDidChange = Notification.Name(rawValue: "currentVideoCallTokenDidChange")
}

private class CurrentVideoCallTokenWatcher: Cancellable {
    // MARK: - Internal
    
    func cancel() {
        notificationCenter.removeObserver(self)
    }
    
    deinit {
        cancel()
    }
    
    init(callback: @escaping (String?) -> Void, notificationCenter: NotificationCenter) {
        self.callback = callback
        self.notificationCenter = notificationCenter
        registerNotification()
    }
    
    // MARK: - Private
    
    private let callback: (_ token: String?) -> Void
    private let notificationCenter: NotificationCenter
    
    private func registerNotification() {
        notificationCenter.addObserver(
            self,
            selector: #selector(didChangeHandler(notification:)),
            name: .currentVideoCallTokenDidChange,
            object: nil
        )
    }
    
    @objc private func didChangeHandler(notification: Notification) {
        let token = notification.userInfo?["token"] as? String
        callback(token)
    }
}
