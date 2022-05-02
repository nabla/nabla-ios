import Foundation
import os

struct ConsoleLogger: Logger {
    func info(message: @autoclosure () -> String) {
        report("[Info] " + message(), type: .info)
    }
    
    func warning(message: @autoclosure () -> String) {
        report("[Warning] " + message(), type: .debug)
    }
    
    func error(message: @autoclosure () -> String) {
        report("[Error] " + message(), type: .error)
    }
    
    private func report(_ message: @autoclosure () -> String, type: OSLogType) {
        os_log(type, "%{public}@", message())
    }
}
