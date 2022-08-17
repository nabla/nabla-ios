import Foundation

public struct NablaResultExtension<Success, Failure: Error> {
    let base: Result<Success, Failure>
    
    init(base: Result<Success, Failure>) {
        self.base = base
    }
}

public extension Result {
    var nabla: NablaResultExtension<Success, Failure> {
        get { NablaResultExtension(base: self) }
        set {}
    }
}

public extension NablaResultExtension {
    var value: Success? {
        switch base {
        case let .success(successValue): return successValue
        case .failure: return nil
        }
    }
    
    var error: Failure? {
        switch base {
        case .success: return nil
        case let .failure(failureError): return failureError
        }
    }
}
