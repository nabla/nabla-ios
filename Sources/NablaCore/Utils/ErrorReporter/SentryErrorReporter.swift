import Foundation
import Sentry

final class SentryErrorReporter: ErrorReporter {
    private let logger: Logger
    private var hub: SentryHub?
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func enable(dsn: String, env: String) {
        let sentryOptions = Options()
        sentryOptions.dsn = dsn
        sentryOptions.environment = env
        sentryOptions.enableCrashHandler = false
        sentryOptions.enableSwizzling = false
        sentryOptions.attachStacktrace = false
        
        let client = Client(options: sentryOptions)
        hub = SentryHub(client: client, andScope: nil)
        
        logger.debug(message: "ErrorReporter enabled for env \(env)")
    }

    func disable() {
        hub = nil
        logger.debug(message: "ErrorReporter disabled")
    }

    func reportError(_ error: Error) {
        logger.debug(message: "ErrorReporter report error")
        hub?.capture(error: error)
    }

    func reportEvent(message: String) {
        logger.debug(message: "ErrorReporter report event (message: \(message))")
        hub?.capture(message: message)
    }

    func log(message: String, metadata: [String: Any]?, domain: String?) {
        logger.debug(message: "ErrorReporter log message \(message)")
        let breadcrumb = Breadcrumb()
        breadcrumb.message = message
        breadcrumb.level = .info
        domain.map { breadcrumb.category = $0 }
        breadcrumb.data = metadata
        hub?.add(breadcrumb)
    }
}
