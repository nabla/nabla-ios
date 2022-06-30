import Foundation

public struct ResultHandler<Success, Failure: Error> {
    // MARK: - Public
    
    public static var void: ResultHandler { .init { _ in } }

    public func callAsFunction(_ result: Result<Success, Failure>) {
        callback(result)
    }

    public func pullback<NewSuccess>(_ transform: @escaping (NewSuccess) -> Success) -> ResultHandler<NewSuccess, Failure> {
        .init {
            callback($0.map(transform))
        }
    }

    public func pullbackError<NewFailure>(_ transform: @escaping (NewFailure) -> Failure) -> ResultHandler<Success, NewFailure> {
        .init {
            callback($0.mapError(transform))
        }
    }
    
    // MARK: Init
    
    public init(_ callback: @escaping (Result<Success, Failure>) -> Void) {
        self.callback = callback
    }
    
    // MARK: - Private

    private let callback: (Result<Success, Failure>) -> Void
}
