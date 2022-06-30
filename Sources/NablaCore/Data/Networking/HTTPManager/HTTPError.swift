import Foundation

public enum HTTPError: Error {
    case transportError(TransportError)
    case serverError(ServerError)
    case decodingError(Error)
    case noSelf
    
    public enum TransportError: Error {
        case unreachableService
        case cancelled
        case generic(Error?)
    }
    
    public enum ServerError: Error {
        case unauthorized
        case unavailableService(Error?)
        case notFound
        case generic(Error?)
    }
}
