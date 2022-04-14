import Foundation

public extension Result {
    var value: Success? {
        switch self {
        case let .success(successValue):
            return successValue
        case .failure:
            return nil
        }
    }

    var error: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(failureError):
            return failureError
        }
    }
}
