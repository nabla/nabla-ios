import Foundation

public enum APIError: Error {
    case unauthorized
    case unavailableService(Error?)
    case unreachableService
    case generic(Error?)
    case cancelled
    case notFound
}
