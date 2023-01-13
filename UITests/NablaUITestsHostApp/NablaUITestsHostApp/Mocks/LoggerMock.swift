import NablaCore
import NablaMessagingCore

final class LoggerMock: Logger {
    func debug(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        print("[DEBUG] \(message()) - Error:\(String(describing: error)) - Extra:\(extra)")
    }
    
    func info(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        print("[INFO] \(message()) - Error:\(String(describing: error)) - Extra:\(extra)")
    }

    func warning(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        print("[WARNING] \(message()) - Error:\(String(describing: error)) - Extra:\(extra)")
    }

    func error(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        print("[ERROR] \(message()) - Error:\(String(describing: error)) - Extra:\(extra)")
    }
}
