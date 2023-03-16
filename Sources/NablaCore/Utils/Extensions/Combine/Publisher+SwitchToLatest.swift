import Combine

public extension NablaPublisherExtension {
    func switchToLatest<P: Publisher>(of other: @escaping (Base.Output) -> P) -> AnyPublisher<P.Output, P.Failure> where P.Failure == Base.Failure {
        base.map(other)
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    func switchToLatest<P: Publisher>(of other: @escaping (Base.Output) -> P) -> AnyPublisher<P.Output, Base.Failure> where P.Failure == Never {
        base.map {
            other($0).setFailureType(to: Base.Failure.self)
        }
        .switchToLatest()
        .eraseToAnyPublisher()
    }
}

public extension NablaPublisherExtension where Base.Failure == Never {
    func switchToLatest<P: Publisher>(of other: @escaping (Base.Output) -> P) -> AnyPublisher<P.Output, P.Failure> {
        base.setFailureType(to: P.Failure.self)
            .map(other)
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    func switchToLatest<P: Publisher>(of other: @escaping (Base.Output) -> P) -> AnyPublisher<P.Output, Base.Failure> where P.Failure == Never {
        base.map(other)
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
