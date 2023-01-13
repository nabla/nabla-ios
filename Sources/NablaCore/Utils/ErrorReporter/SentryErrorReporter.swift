import Foundation
import Sentry

final class SentryErrorReporter: ErrorReporter {
    private let logger: Logger
    private var tags: [String: String] = [:]
    private var extras: [String: String] = [:]
    private var hub: SentryHub?
    
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
        
        let client = Client(options: sentryOptions)
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
        let sentryEvent = Sentry.Event(level: .warning)
        sentryEvent.message = .init(formatted: message)
        sentryEvent.error = error
        sentryEvent.extra = extra
        if let error = error {
            sentryEvent.exceptions = [
                .init(value: message, type: String(describing: type(of: error))),
            ]
        }
        
        hub?.capture(event: sentryEvent)
    }

    func reportError(message: String, error: Error?, extra: [String: Any]) {
        logger.debug(message: "ErrorReporter report error: \(message)")
        let sentryEvent = Sentry.Event(level: .error)
        sentryEvent.message = .init(formatted: message)
        sentryEvent.error = error
        sentryEvent.extra = extra
        if let error = error {
            sentryEvent.exceptions = [
                .init(value: message, type: String(describing: type(of: error))),
            ]
        }
        
        hub?.capture(event: sentryEvent)
    }

    func reportEvent(message: String, extra: [String: Any]) {
        logger.debug(message: "ErrorReporter report event (message: \(message))")
        
        let sentryEvent = Sentry.Event(level: .info)
        sentryEvent.message = .init(formatted: message)
        sentryEvent.extra = extra
        
        hub?.capture(event: sentryEvent)
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
}
