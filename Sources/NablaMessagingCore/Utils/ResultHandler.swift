import Foundation

struct ResultHandler<Success, Failure: Error> {
    static var void: ResultHandler { .init { _ in } }

    init(_ callback: @escaping (Result<Success, Failure>) -> Void) {
        self.callback = callback
    }

    func callAsFunction(_ result: Result<Success, Failure>) {
        callback(result)
    }

    func pullback<NewSuccess>(_ transform: @escaping (NewSuccess) -> Success) -> ResultHandler<NewSuccess, Failure> {
        .init {
            callback($0.map(transform))
        }
    }

    func pullbackError<NewFailure>(_ transform: @escaping (NewFailure) -> Failure) -> ResultHandler<Success, NewFailure> {
        .init {
            callback($0.mapError(transform))
        }
    }

    private let callback: (Result<Success, Failure>) -> Void
}
