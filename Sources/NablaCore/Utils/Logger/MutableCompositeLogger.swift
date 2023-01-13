import Foundation

class MutableCompositeLogger: Logger {
    private var loggers: [Logger] = []
    
    init(_ logger: Logger) {
        loggers.append(logger)
    }
    
    func addLogger(logger: Logger) {
        loggers.append(logger)
    }
    
    public func debug(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        loggers.forEach { logger in
            logger.debug(message: message(), error: error, extra: extra)
        }
    }
    
    public func info(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        loggers.forEach { logger in
            logger.info(message: message(), error: error, extra: extra)
        }
    }
    
    public func warning(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        loggers.forEach { logger in
            logger.warning(message: message(), error: error, extra: extra)
        }
    }
    
    public func error(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        loggers.forEach { logger in
            logger.error(message: message(), error: error, extra: extra)
        }
    }
}
