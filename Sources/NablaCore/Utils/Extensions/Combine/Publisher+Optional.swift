import Combine

public extension NablaPublisherExtension {
    func asOptional() -> AnyPublisher<Base.Output?, Base.Failure> {
        base
            .map { $0 as Base.Output? }
            .eraseToAnyPublisher()
    }
}
