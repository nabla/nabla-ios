import Apollo
import Foundation
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif

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

private extension Error {
    var isNetworkError: Bool {
        if self is NetworkError {
            return true
        }
        if let websocketError = self as? WebSocketError, case .networkError = websocketError.kind {
            // Websocket network errors
            return true
        }
        
        if let websocketError = self as? WebSocketError,
           let underlyingError = websocketError.error as? WebSocket.WSError,
           underlyingError.type == .outputStreamWriteError || underlyingError.type == .writeTimeoutError {
            // Websocket transport errors
            return true
        }
        
        if let nsError = self as NSError?,
           nsError.code == NSURLErrorNotConnectedToInternet ||
           nsError.code == NSURLErrorNetworkConnectionLost ||
           nsError.code == NSURLErrorTimedOut ||
           nsError.code == NSURLErrorCannotConnectToHost ||
           nsError.code == NSURLErrorCannotFindHost ||
           (nsError.domain == "NSPOSIXErrorDomain" && nsError.code == 57) // Special undocumented case: Domain=NSPOSIXErrorDomain Code=57 "Socket is not connected"
        {
            // NSURL && NSPOSIXErrorDomain network errors
            return true
        }
        
        return false
    }
}
