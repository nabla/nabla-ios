// sourcery: AutoMockable
public protocol Logger {
    func debug(message: @autoclosure () -> String, error: Error?, extra: [String: Any])
    func info(message: @autoclosure () -> String, error: Error?, extra: [String: Any])
    func warning(message: @autoclosure () -> String, error: Error?, extra: [String: Any])
    func error(message: @autoclosure () -> String, error: Error?, extra: [String: Any])
}

public extension Logger {
    func debug(message: @autoclosure () -> String) {
        debug(message: message(), error: nil, extra: [:])
    }
    
    func info(message: @autoclosure () -> String) {
        info(message: message(), error: nil, extra: [:])
    }
    
    func warning(message: @autoclosure () -> String) {
        warning(message: message(), error: nil, extra: [:])
    }
    
    func error(message: @autoclosure () -> String) {
        error(message: message(), error: nil, extra: [:])
    }
    
    func debug(message: @autoclosure () -> String, error: Error?) {
        debug(message: message(), error: error, extra: [:])
    }
    
    func info(message: @autoclosure () -> String, error: Error?) {
        info(message: message(), error: error, extra: [:])
    }
    
    func warning(message: @autoclosure () -> String, error: Error?) {
        warning(message: message(), error: error, extra: [:])
    }
    
    func error(message: @autoclosure () -> String, error: Error?) {
        self.error(message: message(), error: error, extra: [:])
    }
    
    func debug(message: @autoclosure () -> String, extra: [String: Any]) {
        debug(message: message(), error: nil, extra: extra)
    }
    
    func info(message: @autoclosure () -> String, extra: [String: Any]) {
        info(message: message(), error: nil, extra: extra)
    }
    
    func warning(message: @autoclosure () -> String, extra: [String: Any]) {
        warning(message: message(), error: nil, extra: extra)
    }
    
    func error(message: @autoclosure () -> String, extra: [String: Any]) {
        error(message: message(), error: nil, extra: extra)
    }
}
