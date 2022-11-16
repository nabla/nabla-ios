import Foundation
import os

public class ConsoleLogger: Logger {
    public enum Level: Int, Comparable {
        case debug
        case info
        case warning
        case error
        
        public static func < (lhs: ConsoleLogger.Level, rhs: ConsoleLogger.Level) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
    
    // MARK: - Public
    
    public var level: Level
    
    public func debug(message: @autoclosure () -> String, extra: [String: Any]) {
        guard level <= .debug else { return }
        report("[Debug] " + message(), extra: extra, type: .debug)
    }
    
    public func info(message: @autoclosure () -> String, extra: [String: Any]) {
        guard level <= .info else { return }
        report("[Info] " + message(), extra: extra, type: .info)
    }
    
    public func warning(message: @autoclosure () -> String, extra: [String: Any]) {
        guard level <= .warning else { return }
        report("[Warning] " + message(), extra: extra, type: .debug)
    }
    
    public func error(message: @autoclosure () -> String, extra: [String: Any]) {
        guard level <= .error else { return }
        report("[Error] " + message(), extra: extra, type: .error)
    }
    
    // MARK: Init
    
    public init(level: Level = .warning) {
        self.level = level
    }
    
    // MARK: - Private
    
    private func report(_ message: @autoclosure () -> String, extra: [String: Any], type: OSLogType) {
        let serialized: String
        if extra.isEmpty {
            serialized = message()
        } else {
            serialized = "\(message()) - \(serialize(extra: extra))"
        }
        os_log(type, "%{public}@", serialized)
    }
    
    private func serialize(extra: [String: Any]) -> String {
        extra
            .sorted(by: { $0.key > $1.key })
            .map { "\($0.key): \($0.value)" }
            .joined(separator: ", ")
    }
}
