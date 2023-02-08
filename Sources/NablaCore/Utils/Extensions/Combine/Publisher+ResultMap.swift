import Combine

public extension NablaPublisherExtension {
    /// Similar to ``Publisher.tryMap`` but with explicit type on the ``Error`` argument.
    /// Returning a `.failure()` output terminates the publishers.
    func resultMap<Success, Failure>(_ transform: @escaping (Base.Output) -> Result<Success, Failure>) -> AnyPublisher<Success, Base.Failure> where Base.Failure == Failure {
        base
            .tryMap { input in
                let result = transform(input)
                switch result {
                case let .failure(error): throw error
                case let .success(output): return output
                }
            }
            .mapError { error in
                guard let error = error as? Failure else { fatalError("Unexpected code path in `Publisher.resultMap`.") }
                return error
            }
            .eraseToAnyPublisher()
    }
}
