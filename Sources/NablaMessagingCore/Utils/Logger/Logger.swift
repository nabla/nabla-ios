// sourcery: AutoMockable
public protocol Logger {
    func info(message: @autoclosure () -> String, extra: [String: Any])
    func warning(message: @autoclosure () -> String, extra: [String: Any])
    func error(message: @autoclosure () -> String, extra: [String: Any])
}

public extension Logger {
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
