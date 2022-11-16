// sourcery: AutoMockable
public protocol Logger {
    func debug(message: @autoclosure () -> String, extra: [String: Any])
    func info(message: @autoclosure () -> String, extra: [String: Any])
    func warning(message: @autoclosure () -> String, extra: [String: Any])
    func error(message: @autoclosure () -> String, extra: [String: Any])
}

public extension Logger {
    func debug(message: @autoclosure () -> String) {
        debug(message: message(), extra: [:])
    }
    
    func info(message: @autoclosure () -> String) {
        info(message: message(), extra: [:])
    }
    
    func warning(message: @autoclosure () -> String) {
        warning(message: message(), extra: [:])
    }
    
    func error(message: @autoclosure () -> String) {
        error(message: message(), extra: [:])
    }
}
