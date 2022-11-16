import Foundation

public protocol ErrorReporter {
    func enable(dsn: String, env: String)

    func disable()

    func reportError(_ error: Error)

    func reportEvent(message: String)

    func log(message: String, metadata: [String: Any]?, domain: String?)
}

public extension ErrorReporter {
    func log(message: String) {
        log(message: message, metadata: nil, domain: nil)
    }

    func log(message: String, metadata: [String: Any]?) {
        log(message: message, metadata: metadata, domain: nil)
    }

    func log(message: String, domain: String?) {
        log(message: message, metadata: nil, domain: domain)
    }
}
