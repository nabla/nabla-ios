import Foundation
import Sentry

final class SentryErrorReporter: ErrorReporter {
    // MARK: - Internal
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func enable(dsn: String, env: String, sdkVersion: String) {
        let sentryOptions = Options()
        sentryOptions.dsn = dsn
        sentryOptions.environment = env
        sentryOptions.releaseName = sdkVersion
        sentryOptions.enableCrashHandler = false
        sentryOptions.enableSwizzling = false
        sentryOptions.attachStacktrace = false
        
        let client = SentryClient(options: sentryOptions)
        hub = SentryHub(client: client, andScope: nil)
        
        hub?.scope.setTags(tags)
        hub?.scope.setExtras(extras)
        
        logger.debug(message: "ErrorReporter enabled for env \(env)")
    }

    func disable() {
        hub = nil
        logger.debug(message: "ErrorReporter disabled")
    }
    
    func reportWarning(message: String, error: Error?, extra: [String: Any]) {
        logger.debug(message: "ErrorReporter report warning: \(message)")
        let event = makeEvent(level: .warning, message: message, error: error, extra: extra)
        hub?.capture(event: event)
    }

    func reportError(message: String, error: Error?, extra: [String: Any]) {
        logger.debug(message: "ErrorReporter report error: \(message)")
        let event = makeEvent(level: .error, message: message, error: error, extra: extra)
        hub?.capture(event: event)
    }

    func reportEvent(message: String, extra: [String: Any]) {
        logger.debug(message: "ErrorReporter report event (message: \(message))")
        let event = makeEvent(level: .info, message: message, error: nil, extra: extra)
        hub?.capture(event: event)
    }

    func log(message: String, extra: [String: Any]?, domain: String?) {
        logger.debug(message: "ErrorReporter log message \(message)")
        let breadcrumb = Breadcrumb()
        breadcrumb.message = message
        breadcrumb.level = .info
        domain.map { breadcrumb.category = $0 }
        breadcrumb.data = extra
        hub?.add(breadcrumb)
    }
    
    func setTag(name: String, value: String) {
        tags[name] = value
        hub?.scope.setTag(value: value, key: name)
    }
    
    func setExtra(name: String, value: String) {
        extras[name] = value
        hub?.scope.setExtra(value: value, key: name)
    }
    
    // MARK: - Private
    
    private let logger: Logger
    private var tags: [String: String] = [:]
    private var extras: [String: String] = [:]
    private var hub: SentryHub?
    
    private func makeEvent(level: SentryLevel, message: String, error: Error?, extra: [String: Any]) -> Sentry.Event {
        let event = Sentry.Event(level: level)
        event.message = .init(formatted: message)
        event.error = error
        event.extra = combine(error: error, extra: extra)
        if let error = error {
            event.exceptions = [
                .init(value: String(describing: type(of: error)), type: message),
            ]
        } else if level == .error {
            event.exceptions = [
                .init(value: "Undefined", type: message),
            ]
        }
        return event
    }
    
    private func combine(error: Error?, extra: [String: Any]) -> [String: Any] {
        guard let error = error else { return extra }
        var copy = extra
        let key = copy["error"] == nil ? "error" : "reason"
        copy[key] = serialize(error: error)
        return copy
    }
    
    private func serialize(error: Error) -> [String: Any] {
        guard let error = error as? NablaError else {
            let nsError = error as NSError
            return ["NSError": nsError.debugDescription]
        }
        var serialized = error.serialize()
        for (key, value) in serialized {
            if let error = value as? Error {
                serialized[key] = serialize(error: error)
            }
        }
        return serialized
    }
}
