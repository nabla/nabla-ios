import Foundation

public protocol ErrorReporter {
    func enable(dsn: String, env: String, sdkVersion: String)

    func disable()

    func reportWarning(message: String, error: Error?, extra: [String: Any])
    
    func reportError(message: String, error: Error?, extra: [String: Any])

    func reportEvent(message: String, extra: [String: Any])

    func log(message: String, extra: [String: Any]?, domain: String?)
    
    func setTag(name: String, value: String)
    
    func setExtra(name: String, value: String)
}

public extension ErrorReporter {
    func log(message: String) {
        log(message: message, extra: nil, domain: nil)
    }

    func log(message: String, extra: [String: Any]?) {
        log(message: message, extra: extra, domain: nil)
    }

    func log(message: String, domain: String?) {
        log(message: message, extra: nil, domain: domain)
    }
    
    func reportWarning(message: String, error: Error?) {
        reportWarning(message: message, error: error, extra: [:])
    }
    
    func reportError(message: String, error: Error?) {
        reportError(message: message, error: error, extra: [:])
    }
    
    func reportEvent(message: String) {
        reportEvent(message: message, extra: [:])
    }
}
