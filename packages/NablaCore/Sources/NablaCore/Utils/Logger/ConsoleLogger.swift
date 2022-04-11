import Foundation
import os

struct ConsoleLogger: Logger {
    func warning(message: @autoclosure () -> String) {
        report("[Warning] " + message(), type: .error)
    }

    private func report(_ message: @autoclosure () -> String, type: OSLogType) {
        os_log(type, "%{public}@", message())
    }
}
