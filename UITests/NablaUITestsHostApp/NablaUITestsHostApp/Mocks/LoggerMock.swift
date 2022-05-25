import NablaMessagingCore

final class LoggerMock: Logger {
    func info(message: @autoclosure () -> String) {
        print("[INFO] \(message())")
    }

    func warning(message: @autoclosure () -> String) {
        print("[WARNING] \(message())")
    }

    func error(message: @autoclosure () -> String) {
        print("[ERROR] \(message())")
    }
}
