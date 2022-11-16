import NablaCore
import NablaMessagingCore

final class LoggerMock: Logger {
    func debug(message: @autoclosure () -> String, extra: [String: Any]) {
        print("[DEBUG] \(message()) - \(extra)")
    }
    
    func info(message: @autoclosure () -> String, extra: [String: Any]) {
        print("[INFO] \(message()) - \(extra)")
    }

    func warning(message: @autoclosure () -> String, extra: [String: Any]) {
        print("[WARNING] \(message()) - \(extra)")
    }

    func error(message: @autoclosure () -> String, extra: [String: Any]) {
        print("[ERROR] \(message()) - \(extra)")
    }
}
