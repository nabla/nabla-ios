import Apollo
import Foundation
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif

extension Error {
    var isAuthenticationError: Bool {
        if let responseCodeError = self as? Apollo.ResponseCodeInterceptor.ResponseCodeError,
           case let .invalidResponseCode(response, _) = responseCodeError,
           response?.statusCode == 401 {
            return true
        }
        if let wsError = self as? WebSocket.WSError {
            return wsError.code == 401 || wsError.message.contains("HTTP_UNAUTHORIZED")
        }
        if let websocketError = self as? WebSocketError, let underlyingError = websocketError.error {
            return underlyingError.isAuthenticationError
        }
        return false
    }
    
    var isInternalServerError: Bool {
        if let wsError = self as? WebSocket.WSError {
            return wsError.code == 500 || wsError.message.contains("HTTP_INTERNAL_SERVER_ERROR")
        }
        if let websocketError = self as? WebSocketError, let underlyingError = websocketError.error {
            return underlyingError.isInternalServerError
        }
        return false
    }
    
    var isNetworkError: Bool {
        if self is NetworkError {
            return true
        }
        if let websocketError = self as? WebSocketError, case .networkError = websocketError.kind {
            return !websocketError.isAuthenticationError && !websocketError.isInternalServerError
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
           nsError.domain == "NSPOSIXErrorDomain" // The error domain used by NSError when reporting SSL errors.

        {
            // NSURL && NSPOSIXErrorDomain network errors
            return true
        }
        
        return false
    }
}
