import Combine
import Foundation

public extension Publisher {
    var nabla: NablaPublisherExtension<Self> {
        NablaPublisherExtension(base: self)
    }
}

public struct NablaPublisherExtension<Base: Publisher> {
    let base: Base
}

public extension NablaPublisherExtension {
    func sink(
        receiveValue: @escaping (Base.Output) -> Void = { _ in },
        receiveError: @escaping (Base.Failure) -> Void
    ) -> AnyCancellable {
        base
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        receiveError(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { output in
                    receiveValue(output)
                }
            )
    }
    
    func drive(
        receiveValue: @escaping (Base.Output) -> Void,
        receiveError: @escaping (Base.Failure) -> Void
    ) -> AnyCancellable {
        base
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        receiveError(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { output in
                    receiveValue(output)
                }
            )
    }
}

public extension NablaExtension where Base: Publisher, Base.Failure == Never {
    func sink(
        receiveValue: @escaping (Base.Output) -> Void = { _ in }
    ) -> AnyCancellable {
        base
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { output in
                    receiveValue(output)
                }
            )
    }
    
    func drive(
        receiveValue: @escaping (Base.Output) -> Void
    ) -> AnyCancellable {
        base
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { output in
                    receiveValue(output)
                }
            )
    }
}
