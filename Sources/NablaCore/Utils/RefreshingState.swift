import Foundation

public enum RefreshingState<Failure: Error> {
    case refreshing
    case refreshed
    case failed(error: Failure)
}

public extension RefreshingState {
    var isRefreshing: Bool {
        switch self {
        case .refreshing: return true
        default: return false
        }
    }
    
    func mapError<F>(_ transform: (Failure) -> F) -> RefreshingState<F> {
        switch self {
        case let .failed(error): return .failed(error: transform(error))
        case .refreshed: return .refreshed
        case .refreshing: return .refreshing
        }
    }
}
