import Combine

public extension NablaPublisherExtension where Base.Failure == Never, Base.Output: Publisher {
    func switchToLatest() -> AnyPublisher<Base.Output.Output, Base.Output.Failure> {
        if #available(iOS 14, *) {
            return base.switchToLatest()
                .eraseToAnyPublisher()
        } else {
            return Publishers.SwitchToLatest(
                upstream: base.setFailureType(to: Base.Output.Failure.self)
            )
            .eraseToAnyPublisher()
        }
    }
}
