import Foundation

class ErrorReporterLogger: Logger {
    private let errorReporter: ErrorReporter
    
    init(
        errorReporter: ErrorReporter,
        publicApiKey: String,
        sdkVersion: String,
        deviceName: String,
        OSVersion: String
    ) {
        self.errorReporter = errorReporter
        
        errorReporter.setExtra(name: "PublicApiKey", value: publicApiKey) // Tags are limited to 200 chars to we use an extra for the API key
        errorReporter.setTag(name: "SdkVersion", value: sdkVersion)
        errorReporter.setTag(name: "DeviceName", value: deviceName)
        errorReporter.setTag(name: "OSVersion", value: OSVersion)
    }

    public func debug(message _: @autoclosure () -> String, error _: Error?, extra _: [String: Any]) {
        // No-op
    }
    
    public func info(message _: @autoclosure () -> String, error _: Error?, extra _: [String: Any]) {
        // No-op
    }
    
    public func warning(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        if let error = error, error.isNetworkError {
            errorReporter.log(message: message(), domain: "network")
            return
        }
        errorReporter.reportWarning(message: message(), error: error, extra: extra)
    }
    
    public func error(message: @autoclosure () -> String, error: Error?, extra: [String: Any]) {
        if let error = error, error.isNetworkError {
            errorReporter.log(message: message(), domain: "network")
            return
        }
        errorReporter.reportError(message: message(), error: error, extra: extra)
    }
}
